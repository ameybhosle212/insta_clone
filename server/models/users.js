const mongoose = require('mongoose')

const UserSchema = new mongoose.Schema({
    name:String,
    DOB:String,
    isAdmin:{
        type:Boolean,
        default:false
    },
    email:{
        type:String
    },
    posts:[
        {
            type:mongoose.Schema.Types.ObjectId,
            ref:'Post'
        }
    ]
})

const User = new mongoose.model('User',UserSchema)

module.exports = User;