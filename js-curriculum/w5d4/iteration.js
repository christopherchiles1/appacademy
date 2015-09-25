function bubbleSort(array){
  if (array.length === 1) { return array; }
  var firstEl = array.shift();

  var returnArr = [firstEl].concat(bubbleSort(array));
  var index = 0;
  while ((index < returnArr.length-1) && (returnArr[index] > returnArr[index + 1])) {
    // swap
    var temp = returnArr[index];
    returnArr[index] = returnArr[index + 1];
    returnArr[index + 1] = temp;
    index++;
  }
return returnArr;
}

// console.log(bubbleSort([3,4,5,23,235,6,7,67]));

function subStrings(string) {
  var result = [];
  for(var i = 0; i < string.length; i++) {
    for(var j = i + 1; j <= (string.length); j++) {
      result.push(string.slice(i, j));
    }
  }
  return result;
}

// console.log(subStrings('cat'));
