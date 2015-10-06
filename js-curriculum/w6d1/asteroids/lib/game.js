(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Game = window.Asteroids.Game = function () {
    this.asteroids = [];
    this.bullets = [];
    this.addAsteroids();
    this.ship = new window.Asteroids.Ship(
      {
        pos: Game.randomPosition(),
        game: this
      }
    );
  };

  Game.DIM_X = 800;
  Game.DIM_Y = 600;
  Game.NUM_ASTEROIDS = 6;

  Game.prototype.addAsteroids = function () {
    while (this.asteroids.length < Game.NUM_ASTEROIDS) {
      this.asteroids.push(new window.Asteroids.Asteroid(
        {
          pos: Game.randomPosition(),
          game: this
        }
      ));
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    ctx.fillStyle = 'blue';
    ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);
    this.allObjects().forEach(function(object){
      object.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.allObjects().forEach(function(object) {
      object.move();
    });
  };

  Game.prototype.wrap = function (pos) {
    var pos1 = (pos[0] + 800) % Game.DIM_X;
    var pos2 = (pos[1] + 600) % Game.DIM_Y;

    return [pos1, pos2];
  };

  Game.randomPosition = function () {
    return [Math.random() * 800, Math.random() * 600];
  };

  Game.prototype.checkCollisions = function () {
    var that = this;
    this.allObjects().forEach( function(object1, idx) {
      for(var j=idx + 1; j < that.allObjects().length; j++) {
        var object2 = that.allObjects()[j];
        if (object1.isCollidedWith(object2)) {
          object1.collideWith(object2);
        }
      }
    });
  };

  Game.prototype.remove = function (obj) {
    if (obj instanceof window.Asteroids.Asteroid) {
      this.asteroids.splice(this.asteroids.indexOf(obj), 1);
    } else if (obj instanceof window.Asteroids.Bullet) {
      this.bullets.splice(this.bullets.indexOf(obj), 1);
    }
  };

  Game.prototype.allObjects = function () {
    return this.bullets.concat(this.asteroids.concat([this.ship]));
  };

})();
