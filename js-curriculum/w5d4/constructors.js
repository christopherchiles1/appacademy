var Cat = function(name, owner) {
  this.name = name;
  this.owner = owner;
};

Cat.prototype = {
  meow: function () { return "Meoooowwwwww"; },
  cuteStatement: function () { return this.owner + ' loves ' + this.name; }
};

// Testing the Cat constructor and prototype
var cat1 = new Cat("Fluffy","Melissa");
var cat2 = new Cat("Marcus", "Edmund");

console.log(cat1.cuteStatement());
console.log(cat1.meow());

console.log(cat2.cuteStatement());
console.log(cat2.meow());

// Overwrites the previous meow function for cat2
cat2.meow = function() {
  return "Meow Meow";
};

console.log(cat1.meow());
console.log(cat2.meow());
