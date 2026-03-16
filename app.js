// app.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// A simple endpoint
app.get('/', (req, res) => {
  res.send('Hello from Node.js app running on EKS!');
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});