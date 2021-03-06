const Post = require('../models/posts');
const User = require('../models/users');
const jwt = require('jsonwebtoken')
const route = require('express').Router()

route.get("/:id", async (req,res)=>{
    const id = req.params.id;
    await User.findById(id).then(data =>{
        if(data){
            console.log(data);
            return res.json(data);
        }return res.json({"DATA":false})
    })
})


route.post("/login", async (req,res)=>{
    const {email, password} = req.body;
    await User.findOne({email:email}).then(data =>{
        if(data){
            const token = jwt.sign({data},'secret');
            return res.json({'id':data._id , 'token':token})
        }else{
            return res.json({'info':false});
        }
    })
})

route.post("/add", async (req,res)=>{
    const {title , bodyPost , id } = req.body;
    var dat = await User.findById(id);
    var data = new Post({
        title:title,
        bodyPost:bodyPost,
        user:id
    })
    dat.posts.push(data._id);
    dat.save()
    data.save();
    return res.json({"DATA":"CORRECT"})
})


route.post("/getAllPost", async (req,res)=>{
    // const { id , token } = req.body;

    const data = await Post.find().populate('user').sort([['date',-1]]);
    var data2 = [];
    data.map((val)=>{
        data2.push({
            'id':val.user._id,
            'name':val.user.name,
            'title':val.title,
            'bodyPost':val.bodyPost
        })
    })
    return res.json(data2);
})

module.exports = route;