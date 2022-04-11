var express = require('express');
var MarketSchema = require('../schema/market_schema');

var router = express.Router();
// CRUD
// GET ALL PRODUCTS
router.get('/',async (req, res, next) => {
  var product = await MarketSchema.find({});
  res.send(product);
});

// GET PRODUCT WITH NAME
router.get('/:name',async (req, res, next) => {
  var product = await MarketSchema.find({name: req.params.name});
  res.send(product);
});

// POST PRODUCT TO DB
router.post('/',async (req, res, next) => {
  var product = await MarketSchema.create({
      name: req.body.name,
      price: req.body.price,
      image: req.body.image,
      category: req.body.category,
  });
  res.send(product);
});

// UPDATE PATCH FROM DB
router.patch('/',async (req, res, next) => {
  var product = await MarketSchema.findOneAndUpdate(
    {name: req.body.oldName},
    {
      name: req.body.name,
      price: req.body.price,
      image: req.body.image,
      category: req.body.category,
  },
  ({new: true}));
  res.send(product);
});
// DELETE FROM DB
router.delete('/',async (req, res, next) => {
  var product = await MarketSchema.findOneAndDelete({name: req.body.oldName});
  res.send(product);
});

module.exports = router;
