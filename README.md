# PhaseTree IaC Task

This repository consists of three main parts:
- Application code written in JavaScript (Node.js) inside `app`.
- Infrastructure declaration using Terraform inside `tf`.
- Deployment workflows using GitHub Actions inside `.github/workflows`.

## Application
The application is a simple Express.js HTTP server with a single GET endpoint. The application reads the `GREET_MESSAGE` environment variable, and the `/greet` returns the value it holds. The application is packaged as a Docker container, with its build instruction specified by the Dockerfile.

In the Dockerfile, I decided to copy the `package.json` file first and run `npm install` on it to make use of the container build caching in Docker. This makes sure that if no change is made to the dependency, Docker will use the cached `node_modules` file and only update the application code.

You can run the application and make a request to the endpoint with the following commands.
```
cd app
docker compose up
curl localhost:3000/greet
```

## Infrastructure
The application is run on top of AWS, managed by Terraform. I used Terraform due to its vendor-agnostic nature, making the transition easier should the need to switch cloud vendor arise in the future. The Terraform definitions are separated into three parts:
- The `aws` directory contains the modules related to each services used: load balancer, CloudWatch, ECR, and ECS.
- The `env` directory defines an environment module that specifies how each service work with each other in an environment (i.e., development and production).
- The `main.tf` file defines the Terraform configuration, AWS provider configuration, and environments configuration.

You can plan the infrastructure provisioning by running the following commands.
```
cd tf
terraform plan -var 'access_key=<AWS_ACCESS_KEY>' -var 'secret_key=<AWS_SECRET_KEY>' -var 'region=<AWS_REGION>'
```

After taking a look at the overview of the changes to be made, you can execute the infrastructure provisioning by running the following command.
```
terraform apply -var 'access_key=<AWS_ACCESS_KEY>' -var 'secret_key=<AWS_SECRET_KEY>' -var 'region=<AWS_REGION>'
```

## Deployment
The application is deployed using GitHub Actions. The deployment to each environment follows a similar series of steps, so I defined a workflow template in the `deploy-template.yaml`. Generally, here are the deployment steps:
- Checkout repository
- Configure AWS and ECR credentials
- Build Docker image
- Render ECS task (replace with the newly built image)
- Apply task definition

This template is then called by `deploy-development.yaml` and `deploy-production.yaml`, each defines the workflow for the development and production environment respectively. Both largely only differs in how they are triggered, except that the production workflow has an environment protection set up. This requires a deployment to the production environment to be approved by the approved reviewer(s) before it can proceed.

## Issues and Challenges
1. I was only able to store the Terraform state files locally due to not having permission to create an S3 bucket (`s3:CreateBucket`). In turn, it does not make sense to implement a workflow to apply changes to the Terraform definitions since there would be virtually no way for the workflow to access the state files.
2. I gave the CloudWatch log group the wrong name (i.e. not having the correct prefix), and could not change it since I lack permission to delete a log group.
3. I lack permission to assign a security group to the load balancer (`ec2:AuthorizeSecurityGroupIngress` and `ec2:AuthorizeSecurityGroupEgress`). This prevented me from making an HTTP request to the deployed service.
4. I lack permission to start a live tail of the logs (`logs:StartLiveTail`). 
5. I lack permission to list deployments of the service (`ecs:ListServiceDeployments`). Together with point 3 and 4, I was unable to directly check if the application was correctly deployed and running. The only way I could check that the deployment workflow ran correctly was by looking at the `image` property of the ECS task definition through `aws ecs describe-task-definition`.