const mongoose = require('mongoose');
require('dotenv').config();

module.exports = async function connectToDb() {
    try {
        await mongoose.connect(process.env.MONGO_URI);
    } catch (error) {
        console.log(error);
        throw (error);
    }
}