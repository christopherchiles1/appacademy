(function () {
  if (typeof window.SnakeGame === "undefined") {
    var SnakeGame = window.SnakeGame = {};
  }

  var Snake = window.SnakeGame.Snake = function (dir, segments) {
    this.dir = dir || "E";
    this.segments = segments || this.defaultSegments();
  };

  Snake.prototype.move = function(){
    this.segments.shift();
    var headCoord = window.Coord(this.segments[this.segments.length - 1], this.dir);
    this.segments.push(headCoord);
  };

  Snake.prototype.turn = function (direction) {
    this.dir = direction;
  };

  Snake.prototype.defaultSegments = function () {
    return [[25, 25], [25, 26]];
  };
})();
