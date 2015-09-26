var Board = function (grid, winState) {
  this.grid = grid || [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
  this.winState = winState || [0,0,0,0,0,0,0,0];
};

Board.prototype.print = function () {
  var printGrid = this.grid.map(function (line) {

    var newLine = line.map( function (el) {
      switch(el) {
        case 0:
          return "   ";
        case 1:
          return " X ";
        case -1:
          return " O ";
      }
    }).join('\u2551');
    return newLine;
  }).join("\n\u2550\u2550\u2550\u256C\u2550\u2550\u2550\u256C\u2550\u2550\u2550\n");
  console.log('\033[2J');
  console.log(printGrid);
};

Board.prototype.deepDup = function () {
  return new Board(this.grid.map(function(row) {
    row.slice();
  }), this.winState.slice());
};

module.exports = Board;
