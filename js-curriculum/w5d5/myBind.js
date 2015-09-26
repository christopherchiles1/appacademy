Function.prototype.myBind = function(ctx) {
  var that = this;
  var args = [].splice.call(arguments, 1);
  var f = function() {
    that.apply(ctx, args);
  };
  return f;
};

var Cat = function(age) {
  this.age = age;
};
var Dog = function(age) {
  this.age = age;
};
Dog.prototype.meow = function(age) {
  this.age += age;
  console.log(this.age);
};
var gizmo = new Cat(25);

var rupert = new Dog(26);

rupert.meow.bind(gizmo, 5)();
console.log("what has science done");
