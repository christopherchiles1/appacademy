(function () {
  if (typeof window.SnakeGame === "undefined") {
    var SnakeGame = window.SnakeGame = {};
  }

  var SnakeView = window.SnakeGame.SnakeView = function ($el) {
    this.board = new SnakeGame.Board();
    this.$el = $el;
  };

  SnakeView.prototype.bindHandlers = function () {
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
