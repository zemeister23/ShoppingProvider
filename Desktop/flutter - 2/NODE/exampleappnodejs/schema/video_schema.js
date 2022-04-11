const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const VideoSchema = Schema({
    name: {
        type: String,
        unique: true,
        required: true,
    },
    url: String,
    duration: Number
});

module.exports = mongoose.model('Video', VideoSchema);