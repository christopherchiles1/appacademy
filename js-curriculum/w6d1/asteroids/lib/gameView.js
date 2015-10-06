(function (root) {
  if (typeof root.Asteroids === 'undefined') {
    root.Asteroids = {};
  }

  var Asteroids = root.Asteroids;

  var GameView = Asteroids.GameView =  function () {
    this.game = new Asteroids.Game();
  };

  GameView.prototype.start = function (canvas) {
    var ctx = canvas.getContext("2d");
    setInterval(this.game.draw.bind(this.game, ctx), 1000 / 60);
    setInterval(this.game.step.bind(this.game), 1000 / 60);
    this.bindKeyHandlers();
  };

  GameView.prototype.bindKeyHandlers = function () {
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
})(this);
