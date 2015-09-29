(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var gameView = window.Asteroids.gameView =  function (game, ctx) {
    this.game = game;
    this.ctx = ctx;
  };

  gameView.prototype.start = function () {
    setInterval(this.game.draw.bind(this.game, this.ctx), 1000 / 60);
    setInterval(this.game.step.bind(this.game), 1000 / 60);
    this.bindKeyHandlers();
  };

  gameView.prototype.bindKeyHandlers = function () {
    var up = function() {
      this.game.ship.power([0, -1]);
    };
    var down = function() {
      this.game.ship.power([0, 1]);
    };
    var left = function() {
      this.game.ship.power([-1, 0]);
    };
    var right = function() {
      this.game.ship.power([1, 0]);
    };
    var space = function () {
      this.game.ship.fireBullet();
    };
    window.key('up', up.bind(this));
    window.key('down', down.bind(this));
    window.key('left', left.bind(this));
    window.key('right', right.bind(this));
    window.key('space', space.bind(this));
  };
})();
