(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = window.TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var that = this;
    this.$el.on("click", function (event) {
      var $square = $(event.target);
      that.makeMove($square);
    });
  };

  View.prototype.makeMove = function ($square) {
    try {
      this.game.playMove($square.data("pos"));
      $square.text(this.game.currentPlayer);
      $square.addClass("checked");
      if (this.game.isOver()) {
        alert("Game over! Winner is " + this.game.winner() + ".");
      }
    }
    catch (e) {
      alert("Invalid Move!!!");
    }
  };

  View.prototype.setupBoard = function () {
    for (var i = 0; i < 9; i++) {
      var $li = $("<li></li>");
      var row = parseInt(i / 3);
      var col = i % 3;
      $li.data("pos", [row,col]);
      this.$el.append($li);
    }
  };
})();
