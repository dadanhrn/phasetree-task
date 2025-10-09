const express = require('express');
const app = express();
const port = 3000;

app.get('/greet', (req, res) => {
  console.log("incoming GET request")
  res.send(process.env.GREETING_MESSAGE || 'Hello world!!!!');
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
