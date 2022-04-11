const mongoose = require('mongoose');

const connectToDb = async () => {
    await mongoose.connect('mongodb://127.0.0.1:27017/video', {useNewUrlParser: true, useUnifiedTopology: true});
    console.log("CONNECT TO DB");
}

module.exports = connectToDb;