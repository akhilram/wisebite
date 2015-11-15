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

  //check if the query is for single item of multiple items
  if(isSingleQuery(keywords))
  {
    async.map(keywords, getTypesFromKeyword,
      function (error, results) {
        res.send(results);
      });
    }
    else{
      // get search results each keywords in parallel
      async.map(keywords, getTypesFromKeyword,
        function (error, results) {
          var ndbs = [];

          for(i = 0; i < results.length; i++)
          ndbs.push(results[i][0].ndbno)

          async.map(ndbs, getDetailsFromNDB, function(err, detail_results){
            res.send(detail_results)
          });
        });
      }
    });

    //Python query parser
    function isSingleQuery(query)
    {
      //TODO: call Linda's python script to determine if its single food item or multiple food items.
      return false;
    }

    function getDetailsFromNDB(ndb, callback)
    {
      var url = 'http://api.nal.usda.gov/ndb/reports/?ndbno='+ndb+'&type=f&format=json&api_key=cK9v2xEPobkXTTEQNmvGN3ndRjuc0n6t4w2Psfj4';
      //console.log(url);
      request(url, function(error, response, body) {
        body = JSON.parse(body);
        callback(error, body);
      });
    }

    // callback to get search results
    function getTypesFromKeyword(keyword, callback) {

      var url = 'http://api.nal.usda.gov/ndb/search?format=json&lt=f&sort=r&api_key=cK9v2xEPobkXTTEQNmvGN3ndRjuc0n6t4w2Psfj4'
      + '&q=' + keyword;
      //console.log(url);
      request(url, function(error, response, body) {
        body = JSON.parse(body);
        callback(error, body.list.item);
      });
    }

router.get('/resolve:true', function (req, res, next) {

    var voice_string = req.query.keywords;
    var PythonShell = require('python-shell');
    //var voice_string = "MILLET FLR";

    var options = {
        mode: 'text',
        pythonPath: 'python',
        pythonOptions: ['-u'],
        scriptPath: '..\\backend python',
        args: [voice_string]
    };

    PythonShell.run('getItems.py', options, function (err, results) {
        if (err) throw err;
        res.send(results);
        // console.log('results: %j', results);
    });

});

module.exports = router;
