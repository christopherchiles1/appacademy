(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var Asteroid = window.Asteroids.Asteroid = function (opts) {
    var attributes = {
      pos: opts['pos'],
      game: opts['game'],
      color: Asteroid.COLOR,
      radius: Asteroid.RADIUS,
      vel: window.Asteroids.Util.randomVec(2)
    };

    window.Asteroids.movingObject.call(this, attributes);
  };

  window.Asteroids.Util.inherits(Asteroid, window.Asteroids.movingObject);

  Asteroid.COLOR = 'red';
  Asteroid.RADIUS = 25;

  Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof window.Asteroids.Ship) {
      otherObject.relocate();
    }
  };


})();
