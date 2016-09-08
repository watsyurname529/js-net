// Generated by CoffeeScript 1.10.0
(function() {
  var b, bias, data, fs, func, i, j, json_file, k, len, math, ref, ref1, ref2, size, w, weights, z_matrix, zip;

  fs = require('fs');

  math = require('mathjs');

  json_file = fs.readFileSync('../neural-net/mnist.json', 'utf8');

  data = JSON.parse(json_file);

  zip = function() {
    var arr, i, j, length, lengthArray, ref, results;
    lengthArray = (function() {
      var j, len, results;
      results = [];
      for (j = 0, len = arguments.length; j < len; j++) {
        arr = arguments[j];
        results.push(arr.length);
      }
      return results;
    }).apply(this, arguments);
    length = Math.min.apply(Math, lengthArray);
    results = [];
    for (i = j = 0, ref = length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      results.push((function() {
        var k, len, results1;
        results1 = [];
        for (k = 0, len = arguments.length; k < len; k++) {
          arr = arguments[k];
          results1.push(arr[i]);
        }
        return results1;
      }).apply(this, arguments));
    }
    return results;
  };

  bias = [];

  weights = [];

  size = data.size;

  console.log(size.length);

  for (i = j = 0, ref = size.length - 1; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
    bias.push(math.matrix(data.bias[i]));
    weights.push(math.matrix(data.weights[i]));
  }

  z_matrix = math.ones(784, 1);

  z_matrix = math.map(z_matrix, func = function(val) {
    return math.random(0, 1);
  });

  ref1 = zip(weights, bias);
  for (k = 0, len = ref1.length; k < len; k++) {
    ref2 = ref1[k], w = ref2[0], b = ref2[1];
    z_matrix = math.multiply(w, z_matrix);
    z_matrix = math.add(z_matrix, b);
    z_matrix = math.map(z_matrix, func = function(val) {
      return math.tanh(val);
    });
  }

  console.log(z_matrix);

}).call(this);
