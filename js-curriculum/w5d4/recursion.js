function fib(n) {
  if (n === 1){ return [0]; }
  if (n === 2){ return [0,1];}

  var prevFibs = fib(n-1);
  var nthFib = prevFibs[n-2] + prevFibs[n-3];
  return prevFibs.concat([nthFib]);
}

function bSearch(array,targetVal){
  var middleIndex = parseInt(array.length / 2);
  if (targetVal === array[middleIndex]) { return middleIndex; }
  if (array.length <= 1){
    return NaN;
  }
  var returnIdx;
  if (targetVal > array[middleIndex]) {
    returnIdx = middleIndex + bSearch(array.slice(middleIndex, array.length), targetVal);
  }
  else {
    returnIdx = bSearch(array.slice(0, middleIndex), targetVal);
  }
  return returnIdx;
}

function mergeSort(array){
  if (array.length <= 1){
    return array;
  }
  var middleIndex = parseInt(array.length / 2);
  var leftArray = array.slice(0,middleIndex);
  var rightArray = array.slice(middleIndex,array.length);

  return merge(mergeSort(leftArray),mergeSort(rightArray));
}

function merge(leftArray, rightArray){
  var mergedArray = [];
  while (leftArray.length > 0 && rightArray.length > 0){
    if (leftArray[0] < rightArray[0]){
      mergedArray.push(leftArray.shift());
    }
    else{
      mergedArray.push(rightArray.shift());
    }
  }
  return mergedArray.concat(leftArray.concat(rightArray));
}
console.log(mergeSort([1,2,5,7,9,11,51,1,51,151,316,46,164,16,41,646,14,6]));
