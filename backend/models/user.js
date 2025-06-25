const mongoose = require('mongoose');
const joi = require('joi');
const jwt = require('jsonwebtoken');
const Joi = require('joi');
require('dotenv').config();

//user model
const mongoSchema = mongoose.Schema({
    firstName:{
        type: String,
        required: true,
    },
    lastName: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true, 
    },
    password: {
        type: String,
        required: true,
    },
    memos: [{
        timeStamp:{
            type: Date,
        },
        content: {
            type: String,
            required: true,
        }
    }]
});

mongoSchema.methods.generateAuthToken = function(){
    const token = jwt.sign({_id:this._id},process.env.JWT_PRIVATE_KEY);
    return token;
}

const User = mongoose.model('User',mongoSchema);

//REST validation
function validateUser(user){
    const Schema = Joi.object({
        firstName: Joi.string().required(),
        lastName: Joi.String().required(),
        email: Joi.String().email().required(),
        password: Joi.String().required(),
    });
    return Schema.validate(user);
}

//exports
module.exports = {
    User,
    validateUser,
}