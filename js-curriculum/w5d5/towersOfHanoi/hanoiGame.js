var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var HanoiGame = function () {
  this.stacks = [[3, 2, 1], [], []];
};

HanoiGame.prototype.isWon = function () {
  return (this.stacks[1].length === 3 || this.stacks[2].length === 3);
};

HanoiGame.prototype.isValidMove = function (fromIdx, toIdx) {
  if (this._validFrom(fromIdx) && this._validTo(fromIdx,toIdx)) { return true; }
  return false;
};

HanoiGame.prototype._validFrom = function(fromIdx) {
  return this.stacks[fromIdx].length > 0;
};

HanoiGame.prototype._validTo = function (fromIdx, toIdx) {
  return (this.stacks[toIdx].length === 0 ||
          this.stacks[fromIdx].slice(-1)[0] < this.stacks[toIdx].slice(-1)[0]);
};

HanoiGame.prototype.move = function (fromIdx, toIdx) {
  if (this.isValidMove(fromIdx, toIdx)) {
    this.stacks[toIdx].push(this.stacks[fromIdx].pop());
    return true;
  }
  return false;
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Select tower to move from:", function(input) {
    reader.question("Select tower to move to:", function(input2){
      var fromIdx = parseInt(input);
      var toIdx = parseInt(input2);
      callback(fromIdx, toIdx);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
    var that = this;
    var callback = function(fromIdx, toIdx) {
      if (that.move(fromIdx, toIdx)) {
        if (that.isWon()) {
          completionCallback();
        } else {
          that.promptMove(callback);
        }
      } else {
        console.log("Invalid move! Please enter again");
        that.promptMove(callback);
      }
    };
    this.promptMove(callback);
};

var game = new HanoiGame();
var completionCallback = function() {
  console.log("Congratulations! You won or cheated!");
  reader.close();
};
game.run(completionCallback);
