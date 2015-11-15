var express = require('express');
var app = express();
var router = express.Router();
var bodyParser = require('body-parser');
var async = require('async');
var request = require('request');

app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({extended: true})); // support encoded bodies

/* GET food listing. */
router.get('/', function (req, res, next) {
  var ndb = req.query.ndb;
  //use ndb to get the details of the product.
  getFoodDetailsFromNDB(ndb, function(err, result){
    if(!err){
      res.send(result);
    }
    else{
      console.log("Error in querying using NDB");
      res.end();
    }
  })
  });

  // callback to get search results
  function getFoodDetailsFromNDB(ndb, callback) {

    var url = 'http://api.nal.usda.gov/ndb/reports/?ndbno='+ndb+'&type=f&format=json&api_key=cK9v2xEPobkXTTEQNmvGN3ndRjuc0n6t4w2Psfj4';
    //console.log(url);
    request(url, function(error, response, body) {
      body = JSON.parse(body);
      callback(error, body);
    });
  }

  module.exports = router;
