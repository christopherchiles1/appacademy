var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function(sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {
    completionCallback(sum);
  } else {
    var callback = function (input) {
      sum += parseInt(input);
      addNumbers(sum, numsLeft - 1, completionCallback);
    };
    reader.question("Enter a number: ", callback);
  }
};

addNumbers(0, 3, function (sum) {
  reader.close();
  console.log(sum);
});
