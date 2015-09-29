// sum
function sum() {
  var args = Array.prototype.slice.call(arguments);
  var s = 0;
  args.forEach( function (el) {
    s += el;
  });
  return s;
}
//console.log(sum(1,2,3,54));

// myBind with args
Function.prototype.myBind = function(context) {
  var that = this;
  var args = Array.prototype.slice.call(arguments, 1);
  var fun = function () {
    var args2 = Array.prototype.slice.call(arguments);
    that.apply(context, args.concat(args2));
  };
  return fun;
};

// function Cat(name) {
//   this.name = name;
// }
//
// Cat.prototype.says = function (sound) {
//   console.log(this.name + " says " + sound + "!");
// };
//
// var markov = new Cat("Markov");
// var breakfast = new Cat("Breakfast");
//
// markov.says("meow"); // Markov says meow!
//
// markov.says.myBind(breakfast, "meow")(); // Breakfast says meow!
//
// markov.says.myBind(breakfast)("meow"); // Breakfast says meow!
//
// var notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow"); // Breakfast says meow!

//curriedSum

function curriedSum(numArgs) {
  var numbers = [];
  var _curriedSum = function (num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      var s = 0;
      numbers.forEach( function (el) {
        s += el;
      });
      return s;
    } else {
      return _curriedSum;
    }
  };
  return _curriedSum;
}

// var sum = curriedSum(4);
// var answer = sum(5)(30)(20)(1); // => 56
// console.log(answer);

// Function#curry(numArgs)
Function.prototype.curry = function(numArgs) {
  var args = [];
  var that = this;
  var _curry = function(arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return that.apply(null, args);
    } else {
      return _curry;
    }
  };
  return _curry;
};

var original = sum.curry(4);
console.log(original(4)(5)(3)(6));
