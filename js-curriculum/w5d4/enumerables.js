function toPrint(element){
  console.log(element);
}

function timesTwo(element){
  return (element * 2);
}

function substractInject(accum, el){
  return accum + el;
}

Array.prototype.myEach = function(func){
  for (var i=0; i < this.length; i++){
    func(this[i]);
  }
};

function myMap(array, func){
  var result = [];
  array.myEach(function(el) { result.push(func(el)); });
  return result;
}

function myInject(array, func) {
  // var accum = parseInt(array.slice(0, 1));
  var accum = array[0];
  array.slice(1, array.length).myEach(function(el) { accum = func(accum, el); });
  return accum;
}

var random = [1,2,3,4,5];
console.log(myInject(random, substractInject));
