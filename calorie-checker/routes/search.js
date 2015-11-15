var express = require('express');
var app = express();
var router = express.Router();
var bodyParser = require('body-parser');
var async = require('async');
var request = require('request');
var pythonShell = require('python-shell');

app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({extended: true})); // support encoded bodies

/* GET food listing. */
router.get('/', function (req, res, next) {

    //keywords is a single query. Not to be mistaken for an array of keywords.
    var keywords = req.query.keywords;

    var products = getProductsFromKeywords(keywords);
    //check if the query is for single item of multiple items
    if (products.length == 1) {
        async.map(products, getSearchResults,
            function (error, results) {
                res.send(results);
            });
    } else {
        // get search results each keywords in parallel
        async.map(products, getSearchResults,
            function (error, results) {
                var ndbNumbers = [];

                // use ndb numbers to retrieve food reports for requested products
                for (var i = 0; i < results.length; i++)
                    ndbNumbers.push(results[i][0].ndbno)

                async.map(ndbNumbers, getFoodDetailsFromNDB, function (err, detail_results) {
                    res.send(detail_results)
                });
            });
    }
});

function getProductsFromKeywords(keywords) {

    //var options = {
    //    mode: 'text',
    //    pythonPath: 'python',
    //    pythonOptions: ['-u'],
    //    scriptPath: './scripts/backend python',
    //    args: [keywords]
    //};
    //
    //pythonShell.run('getItems.py', options, function (err, results) {
    //    if (err) throw err;
    //    return results.split(',');
    //});
    //return ['cheese'];
    return ['cheese', 'butter'];
}

// callback to get food report
function getFoodDetailsFromNDB(ndb, callback) {

    var url = 'http://api.nal.usda.gov/ndb/reports/?ndbno=' + ndb + '&type=f&format=json&api_key=cK9v2xEPobkXTTEQNmvGN3ndRjuc0n6t4w2Psfj4';
    request(url, function (error, response, body) {
        body = JSON.parse(body);
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
