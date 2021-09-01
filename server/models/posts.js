const mongoose = require('mongoose')

const PostSchema = new mongoose.Schema({
    title:{
        type:String
    },
    bodyPost:{
        type:String
    },
    user:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
    }
})

const Post = new mongoose.model('Post',PostSchema)

module.exports = Post;