var express = require('express');
var app = express();
var router = express.Router();
var bodyParser = require('body-parser');
var request = require('request');

app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({extended: true})); // support encoded bodies

/* GET nutrient info. */
router.get('/', function (req, res, next) {

    var url = 'http://api.nal.usda.gov/ndb/reports?type=f&format=json&api_key=cK9v2xEPobkXTTEQNmvGN3ndRjuc0n6t4w2Psfj4'
        + '&ndbno=' + req.query.ndbno;
    request(url, function(error, response, body) {
        body = JSON.parse(body);
        res.send(body.report.food);
    });
});

module.exports = router;