const mongoose = require('mongoose')
require('dotenv').config()
const axios = require('axios')
const User = require('./models/users')

// DB

mongoose.connect(process.env.Mongo_URL,{useNewUrlParser:true,useNewUrlParser:true,useUnifiedTopology:true}).then(()=>{
    console.log("DB CONNECTED");
})


