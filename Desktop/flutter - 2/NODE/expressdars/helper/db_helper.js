var mongoose = require('mongoose');

const mongooseCon = () => {
    var mongoDB = 'mongodb://127.0.0.1:27017/market';
    mongoose.connect(mongoDB, {useNewUrlParser: true, useUnifiedTopology: true});

    var db = mongoose.connection;

    db.on('error', console.error.bind(console, 'MongoDB connection error:'));
}

module.exports = mongooseCon;