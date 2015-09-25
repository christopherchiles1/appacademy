var uniq = function (arr) {
  var result = [];
  for ( var i = 0; i < arr.length; i++) {
    var flag = false;
    for ( var j = 0; j < result.length; j++) {
      flag = (arr[i] === result[j]);
      if (flag) { break; }
    }
    if (!flag) {
      result.push(arr[i]);
    }
  }
  return result;
};

// var array = [1, 2, 2, 3, 1, 1, 2, 3, 4];
// console.log(array);
// console.log(uniq(array));

function twoSum(arr) {
  var result = [];
  for ( var i = 0; i < arr.length; i++ ) {
    for ( var j = i + 1; j < arr.length; j++ ) {
      if ( (arr[i] + arr[j]) === 0 ) {
        result.push([i, j]);
      }
    }
  }
  return result;
}

// var array = [-1, 0, 2, -2, 0, 1];
// console.log(array);
// console.log(twoSum(array));

function transpose(arr) {
  var result = [];
  for ( var i = 0; i < arr.length; i++ ) {
    var transposedRow = [];
    for ( var j = 0; j < arr[0].length; j++ ) {
      transposedRow.push(arr[j][i]);
    }
    result.push(transposedRow);
  }
  return result;
}

var matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
console.log(matrix);
console.log(transpose(matrix));
