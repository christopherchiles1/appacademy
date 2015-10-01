(function () {
  if (typeof window.SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var Board = window.SnakeGame.Board = function () {
    this.snake = new window.SnakeGame.Snake();
  };

  Board.SIZE = 50;

  Board.prototype.step = function () {
    this.snake.move();
  };

  // TODO: Add apple functionality

  // Board.prototype.render = function () {
  //   for (var i = 0; i < Board.SIZE; i++) {
  //     for (var j = 0; j < Board.SIZE; j++){
  //         //
  //     }
  //   }
  // };



})();
