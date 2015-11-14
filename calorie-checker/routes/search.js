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
    var keywords = req.query.keywords;

    // get search results each keywords in parallel
    async.map(keywords, getFoodDetailsFromNDB,
        function (error, results) {
            res.send(results);
        });
});

// callback to get search results
function getFoodDetailsFromNDB(keyword, callback) {

    var url = 'http://api.nal.usda.gov/ndb/search?format=json&lt=f&sort=r&api_key=cK9v2xEPobkXTTEQNmvGN3ndRjuc0n6t4w2Psfj4'
        + '&q=' + keyword;
    console.log(url);
    request(url, function(error, response, body) {
        body = JSON.parse(body);
        callback(error, body.list.item);
    });
}

module.exports = router;
