(function () {
  if (typeof window.Hanoi === 'undefined'){
    window.Hanoi = {};
  }

  var View = window.Hanoi.View = function(game, $el){
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.installHandlers();
    this.render();
  };

  View.prototype.setupTowers = function () {
    for (var i = 0; i < 3; i++) {
      var $pile = $("<ul class='group'>");
      $pile.data("pos", i);

      for (var j = 0; j < 3; j++) {
        var $disc = $("<li>");
        if (i === 0) {
          $disc.data("val", j + 1);
        }

        $pile.append($disc);
      }
      this.$el.append($pile);
    }
  };

  View.prototype.render = function () {
    var $discs = $("li");
    $discs.each( function (i) {
      var disc = $discs[i];
      var $disc = $(disc);
      if ($disc.data("val")) {
        var discWidth = $disc.data("val") * 50;
        $disc.css("width", discWidth );
        $disc.addClass("disc");
      } else {
        $disc.removeClass("disc");
      }
    });
  };

  View.prototype.installHandlers = function () {
    var towers = [];
    var that = this;

    this.$el.find("ul").on("click", function(e) {
      var $pile = $(e.currentTarget);
      var pos = $pile.data("pos");
      towers.push(pos);

      if (towers.length === 2){
        if (that.game.move(towers[0], towers[1])) {
          var $fromTower = $('ul:nth-of-type(' + (towers[0] + 1) + ')');
          var $toTower = $('ul:nth-of-type(' + (towers[1] + 1) + ')');

          var $moveDisc = $fromTower.find('.disc').eq(0);
          var $toDisc = $toTower.find('li:not(.disc)').last();

          $toDisc.data("val", $moveDisc.data("val"));
          $moveDisc.data("val", null);

          that.render();
        } else {
          alert("Invalid move!");
        } towers = [];
      }

      if (that.game.isWon()) {
        alert('Winner, winner Hanoi chicken dinner!');
      }
    });
  };
})();
