Function.prototype.inherits = function(parent) {
  var child = this;
  function Surrogate () {}
  Surrogate.prototype = parent.prototype;
  child.prototype = new Surrogate();
  child.prototype.constructor = child;
};


function MovingObject (position, speed) {
  this.position = position;
  this.speed = speed;
}
MovingObject.prototype.move = function() {
  console.log("Moved");
};

function Ship () {
  this.lives = 3;
}
Ship.inherits(MovingObject);
Ship.prototype.fire = function () {
  console.log("Pew pew");
};

function Asteroid (size) {
  this.size = size;
}
Asteroid.inherits(MovingObject);

var ship = new Ship();
var asteroid = new Asteroid(Math.random());

console.log(ship.__proto__);
console.log(asteroid.prototype);
ship.move();
asteroid.move();
ship.fire();
asteroid.fire();
