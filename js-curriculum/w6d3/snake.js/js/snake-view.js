(function () {
  if (typeof window.SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var SnakeView = window.SnakeGame.SnakeView = function ($el) {
    this.$el = $el;
    this.board = new window.SnakeGame.Board();
    this.setupBoard();
    this.bindEvents();
  };

  SnakeView.prototype.start = function () {
    setInterval(this.render, 1000 / 12);
  };

  SnakeView.prototype.render = function () {
    var oldTailCoord = this.snake.tail();
    this.board.step();
    var newHeadCoord = this.snake.head();
    // TODO: removeClass snake on oldTail and add it on newHead
  }

  SnakeView.prototype.setupBoard = function () {
    for (var i = 0; i < window.SnakeGame.Board.SIZE; i++) {
      for (var j = 0; j < window.SnakeGame.Board.SIZE; j++) {
        $tile = $("<div>").addClass("tile");
        $tile.data("coord", [i, j]);
        this.$el.append($tile);
      }
    }
    // TODO: run through snake segments and update board
  };

  SnakeView.prototype.bindEvents = function () {
    this.$el.on("keydown", this.handleKeyEvent(event) );
  };

  SnakeView.prototype.handleKeyEvent = function (event) {
    var key = event.keyCode;

    switch (key) {
      case 38:  //up
        window.Snake.turn("N");
        break;
      case 40:  //down
        window.Snake.turn("S");
        break;
      case 39:  //right
        window.Snake.turn("E");
        break;
      case 37:  //left
        window.Snake.turn("W");
        break;
    }
  };

})();
