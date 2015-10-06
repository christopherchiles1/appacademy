(function (root) {
  if (typeof root.Asteroids === 'undefined') {
    root.Asteroids = {};
  }

  var Asteroids = root.Asteroids;

  var MovingObject = Asteroids.MovingObject = function (opts) {
    this.pos = opts['pos'];
    this.vel = opts['vel'];
    this.radius = opts['radius'];
    this.color = opts['color'];
    this.game = opts['game'];
  };

  MovingObject.prototype.draw = function(ctx) {
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

  MovingObject.prototype.move = function() {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
    this.pos = this.game.wrap(this.pos);
  };

  MovingObject.prototype.isCollidedWith = function (otherObject) {
    var dist = Asteroids.Util.distance(this.pos, otherObject.pos);
    return (dist < (this.radius + otherObject.radius));
  };

  MovingObject.prototype.collideWith = function (otherObject) {

  };
})(this);
