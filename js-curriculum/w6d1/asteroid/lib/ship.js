(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var Ship = window.Asteroids.Ship = function (opts) {
    var attributes = {
      game: opts['game'],
      pos: opts['pos'],
      vel: [0, 0],
      radius: Ship.RADIUS,
      color: Ship.COLOR
    };
    window.Asteroids.movingObject.call(this, attributes);
  };

  window.Asteroids.Util.inherits(Ship, window.Asteroids.movingObject);

  Ship.RADIUS = 30;
  Ship.COLOR = 'black';

  Ship.prototype.relocate = function () {
    this.pos = window.Asteroids.Game.randomPosition();
    this.vel = [0,0];
  };

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

  Ship.prototype.fireBullet = function () {
    var bullet = new window.Asteroids.Bullet(
      {
        game: this.game,
        pos: this.pos,
        vel: this.vel.map(function(el) { return el * 2; })
      }
    );
    this.game.bullets.push(bullet);
  };
})();
