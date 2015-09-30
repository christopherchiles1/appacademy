(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var gameView = window.Asteroids.gameView =  function () {
    this.game = new window.Asteroids.Game();
  };

  gameView.prototype.start = function (canvas) {
    var ctx = canvas.getContext("2d");
    setInterval(this.game.draw.bind(this.game, ctx), 1000 / 60);
    setInterval(this.game.step.bind(this.game), 1000 / 60);
    this.bindKeyHandlers();
  };

  gameView.prototype.bindKeyHandlers = function () {
    window.key('up', function() {
        this.game.ship.power([0, -1]);
      }.bind(this));
    window.key('down', function() {
      this.game.ship.power([0, 1]);
    }.bind(this));
    window.key('left', function() {
      this.game.ship.power([-1, 0]);
    }.bind(this));
    window.key('right', function() {
      this.game.ship.power([1, 0]);
    }.bind(this));
    window.key('space', function () {
      this.game.ship.fireBullet();
    }.bind(this));
  };
})();
