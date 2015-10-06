(function (root) {
  if (typeof root.Asteroids === 'undefined') {
    root.Asteroids = {};
  }

  var Asteroids = root.Asteroids;

  var Ship = Asteroids.Ship = function (opts) {
    var attributes = {
      game: opts['game'],
      pos: opts['pos'],
      vel: [0, 0],
      radius: Ship.RADIUS,
      color: Ship.COLOR
    };
    Asteroids.MovingObject.call(this, attributes);
  };

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.RADIUS = 30;
  Ship.COLOR = 'black';

  Ship.prototype.relocate = function () {
    this.pos = Asteroids.Game.randomPosition();
    this.vel = [0,0];
  };

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

  // TODO: Add a bullet fired cooldown
  // TODO: Add a finite number of bullets (and a HUD?)
  Ship.prototype.fireBullet = function () {
    var bullet = new Asteroids.Bullet(
      {
        game: this.game,
        pos: this.pos,
        vel: this.vel.map(function(el) { return el * 2; })
      }
    );
    this.game.bullets.push(bullet);
  };
})(this);
