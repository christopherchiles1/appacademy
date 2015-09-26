var Player = function (name, piece, reader) {
  this.name = name;
  this.piece = piece;
  this.reader = reader;
};

Player.prototype.promptMove = function (callback) {
  var that = this;
  that.reader.question("Please enter a row: ", function(inputRow) {
    that.reader.question("Please enter a col: ", function(inputCol) {
      var row = parseInt(inputRow);
      var col = parseInt(inputCol);
      callback(row,col);
    });
  });
};


module.exports = Player;
