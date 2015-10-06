var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var absurdBubbleSort = function(arr, sortCompletetionCallBack) {
  var outerBubbleSortLoop = function(madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletetionCallBack(arr);
    }
  };
  outerBubbleSortLoop(true);
};

var askIfGreaterThan = function(el1, el2, callback) {
  reader.question("Is " + el1 + " > " + el2 + "? ", function(input) {
    if (input === 'yes') {
      callback(true);
    } else {
      callback(false);
    }
  });
};

var innerBubbleSortLoop = function(arr,i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    var callback = function(isGreaterThan) {
      console.log(i);
      if (isGreaterThan) {
        var temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
        madeAnySwaps = true;
      }
        innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    };
    askIfGreaterThan(arr[i], arr[i+1], callback);
  }  else if (i === (arr.length - 1)) {
    outerBubbleSortLoop(madeAnySwaps);
  }
};

absurdBubbleSort([3, 1, 2], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
