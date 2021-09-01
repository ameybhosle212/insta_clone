const express = require('express')
const app = express()
const cors = require('cors')
const mongoose = require('mongoose')
require('dotenv').config()

// DB

mongoose.connect(process.env.Mongo_URL,{useNewUrlParser:true,useNewUrlParser:true,useUnifiedTopology:true}).then(()=>{
    console.log("DB CONNECTED");
})

// Middleware

app.use(express.json())
app.use(cors())
app.use(express.urlencoded({extended:true}))

// Routes

app.use("/",require("./routes/route"))


// Server

app.listen(3001,()=>{
    console.log("SERVER AT 3001");
})