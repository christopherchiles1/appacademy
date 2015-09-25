var Cat = function(name, owner) {
  this.catName = name;
  this.owner = owner;
};


Cat.prototype = {
  meow: function(){return "Meoooowwwwww";},
  cuteStatement: function() {return (this.owner + ' loves ' + this.catName);}
};
var kittyCat = new Cat("Snow White","Sr. Edward Wang");
var kitCat = new Cat("Telly Tubby", "DwightWare");

console.log(kittyCat.cuteStatement());
console.log(kitCat.cuteStatement());

console.log(kittyCat.meow());
console.log(kitCat.meow());

kitCat.meow = function() {
  return "Meow Meow";
};

console.log(kitCat.meow());
