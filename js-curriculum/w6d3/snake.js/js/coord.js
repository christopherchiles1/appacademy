(function () {
  if (typeof window.SnakeGame === "undefined") {
    var SnakeGame = window.SnakeGame = {};
  }
  var Coord = window.SnakeGame.Coord = function (x, y) {
    this.x = x;
    this.y = y;
  };

  Coord.DIRS = {
    N: [0, -1],
    W: [-1, 0],
    S: [0, 1],
    E: [1, 0]
  };

  Coord.prototype.plus = function (coord, dir) {
    var newX = coord[0] + Coord.DIRS[dir][0];
    var newY = coord[1] + Coord.DIRS[dir][1];
    return [newX, newY];
  };

})();
