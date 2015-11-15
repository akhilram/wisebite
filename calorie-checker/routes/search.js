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

    //keywords is a single query. Not to be mistaken for an array of keywords.
    var keywords = req.query.keywords;

    resolveQueryAndProcessData(keywords, res);

});

function resolveQueryAndProcessData(keywords, res) {

    var url = 'https://ancient-temple-5572.herokuapp.com/?key=' + keywords;

    request(url, function (error, response, body) {
        //console.log(body.split(","));
        processProducts(body.split(",") ,res);
    });
}

function processProducts(products, res) {

    ////check if the query is for single item of multiple items
    if (products.length == 1) {
        async.map(products, getSearchResults,
            function (error, results) {
                res.send({type: "search", results: results});
            });
    } else {
        // get search results each keywords in parallel
        async.map(products, getSearchResults,
            function (error, results) {
                var ndbNumbers = [];

                // use ndb numbers to retrieve food reports for requested products
                for (var i = 0; i < results.length; i++)
                    ndbNumbers.push(results[i][0].ndbno)

                async.map(ndbNumbers, getFoodDetailsFromNDB, function (err, report) {
                    res.send({type: "report", results: report});
                });
            });
    }
}

// callback to get food report
function getFoodDetailsFromNDB(ndb, callback) {

    var url = 'http://api.nal.usda.gov/ndb/reports/?ndbno=' + ndb + '&type=f&format=json&api_key=cK9v2xEPobkXTTEQNmvGN3ndRjuc0n6t4w2Psfj4';
    request(url, function (error, response, body) {
        body = JSON.parse(body);

        var requiredNutrients = {
            208:"Calorie",
            203:"Protein",
            204:"Total Fat",
            291:"Total Fiber",
            205:"Carbohydrates",
            269:"Total Sugar"
        };

        var nutrients = [];

        for (var i=0; i<body.report.food.nutrients.length; i++) {
            if(body.report.food.nutrients[i].nutrient_id in requiredNutrients) {
                nutrients.push(body.report.food.nutrients[i]);
            }
        }
        body.report.food.nutrients = nutrients;
        callback(error, body);
    });
}

// callback to get search results
function getSearchResults(products, callback) {

    var url = 'http://api.nal.usda.gov/ndb/search?format=json&lt=f&sort=r&max=10&api_key=cK9v2xEPobkXTTEQNmvGN3ndRjuc0n6t4w2Psfj4'
        + '&q=' + products;
    request(url, function (error, response, body) {
        body = JSON.parse(body);
        callback(error, body.list.item);
    });
}

module.exports = router;
