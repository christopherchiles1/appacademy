var TTT = require('./ttt');

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var game = new TTT.Game(reader, "austin", "chris");
game.run(function(name) {
  if (name) {
    console.log("Congratulations! " + name + " has won!");
  } else {
    console.log("The game has ended in a tie!");
  }
  reader.close();
});
