(function () {
  if (typeof window.SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var Snake = window.SnakeGame.Snake = function () {
    this.dir = Snake.DIRS[0];
    this.segments = this.defaultSegments();
  };

  Snake.DIRS = ["E", "S", "W", "N"];

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

  Snake.prototype.head = function () {
    this.segments[this.segments.length - 1];
  };

  Snake.prototype.tail = function () {
    this.segments[0];
  };
})();
