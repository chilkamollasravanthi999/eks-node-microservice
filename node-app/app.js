const express = require('express')
const app = express()

app.get('/', (req,res)=>{
    res.send("Node Microservice running in EKS ThankYou")
})

app.listen(3000,()=>{
    console.log("Server running on port 3000")
})