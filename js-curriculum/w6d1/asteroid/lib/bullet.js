(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Bullet = window.Asteroids.Bullet = function (opts) {
    var attributes = {
      game: opts['game'],
      pos: opts['pos'],
      vel: opts['vel'],
      radius: Bullet.RADIUS,
      color: Bullet.COLOR
    };

    window.Asteroids.movingObject.call(this, attributes);
  };

  window.Asteroids.Util.inherits(Bullet, window.Asteroids.movingObject);

  Bullet.RADIUS = 8;
  Bullet.COLOR = 'magenta';

  Bullet.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof window.Asteroids.Asteroid) {
      this.game.remove(otherObject);
      this.game.remove(this);
    }
  };

})();
