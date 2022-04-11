var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var MarketSchema = new Schema({
    name: {
        type: String,
        unique: true,
        required: true,
        max: 30
    },
    price: Number,
    image: String,
    category: String
});

module.exports = mongoose.model('Market', MarketSchema);