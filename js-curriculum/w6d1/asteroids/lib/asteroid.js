(function (root) {
  if (typeof root.Asteroids === 'undefined') {
    root.Asteroids = {};
  }

  var Asteroids = root.Asteroids;

  // TODO: Add image/size variety to Asteroids
  var Asteroid = Asteroids.Asteroid = function (opts) {
    var attributes = {
      pos: opts['pos'],
      game: opts['game'],
      color: Asteroid.COLOR,
      radius: Asteroid.RADIUS,
      vel: Asteroids.Util.randomVec(2)
    };

  Asteroid.COLOR = 'red';
  Asteroid.RADIUS = 25;

    Asteroids.MovingObject.call(this, attributes);
  };

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);


  Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    }
  };


})(this);
