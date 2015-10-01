(function () {
  if (typeof window.SnakeGame === "undefined") {
    var SnakeGame = window.SnakeGame = {};
  }

  var Board = window.SnakeGame.Board = function () {
    this.snake = new SnakeGame.Snake();
    this.grid = Board.render();
  };

  Board.SIZE = 50;

  Board.prototype.render = function () {
    for (var i = 0; i < Board.SIZE; i++) {
      for (var j = 0; j < Board.SIZE; j++){
          //
      }
    }
  };



})();
