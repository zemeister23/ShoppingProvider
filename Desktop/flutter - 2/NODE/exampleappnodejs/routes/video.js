var express = require('express');
var router = express.Router();

const Video = require('../schema/video_schema');

/* GET users listing. */
router.get('/',async (req, res, next) => {
  const data = await Video.find({});
  res.send(data);
});

// POST VIDEO
router.post('/', async (req,res) => {
  const data = await  Video.create({
    name: req.body.name,
    url: req.body.url,
    duration: req.body.duration
  });
  res.send(data);
});

module.exports = router;
