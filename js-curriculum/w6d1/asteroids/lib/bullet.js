(function (root) {
  if (typeof root.Asteroids === "undefined") {
    root.Asteroids = {};
  }

  var Asteroids = root.Asteroids;

  var Bullet = Asteroids.Bullet = function (opts) {
    var attributes = {
      game: opts['game'],
      pos: opts['pos'],
      vel: opts['vel'],
      radius: Bullet.RADIUS,
      color: Bullet.COLOR
    };

    Asteroids.MovingObject.call(this, attributes);
  };

  Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);

  Bullet.RADIUS = 8;
  Bullet.COLOR = 'magenta';

  Bullet.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Asteroid) {
      this.game.remove(otherObject);
      this.game.remove(this);
    }
  };

})(this);
