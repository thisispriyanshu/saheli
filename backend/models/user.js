const mongoose = require('mongoose');


const userSchema = new mongoose.Schema({
    name:{
        type: String,
        required: true
    },
    email:{
        type:String,
        required:true
    },
    phone_number:{
        type: Number,
        required:true,
        unique:true
    },
    gender:{
        type: String,
        enum:['Male','Female'],
        default:'Female'
    },
    firebase_uid:{
        type: String,
        required:true,
        unique:true
    },
    dob:{
        type: Date,
    },
    auth_method:{
        type: String,
        enum:['Google','Email'],
        default:'Email',
        required:true
    },
});

const User = mongoose.model('User', userSchema);

module.exports = User;