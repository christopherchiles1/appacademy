(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var movingObject = window.Asteroids.movingObject = function (opts) {
    this.pos = opts['pos'];
    this.vel = opts['vel'];
    this.radius = opts['radius'];
    this.color = opts['color'];
    this.game = opts['game'];
  };

  movingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.strokeStyle = 'black';
    ctx.beginPath();
    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI,
      false
    );
    ctx.closePath();

    ctx.fill();
    ctx.stroke();
  };

  movingObject.prototype.move = function() {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
    this.pos = this.game.wrap(this.pos);
  };

  movingObject.prototype.isCollidedWith = function (otherObject) {
    var dist = window.Asteroids.Util.distance(this.pos, otherObject.pos);
    return (dist < (this.radius + otherObject.radius));
  };

  movingObject.prototype.collideWith = function (otherObject) {
    
  };
})();
