var Board = require('./board.js');
var Player = require('./player.js');

var Game = function (reader, playerName1, playerName2) {
  var player1 = new Player(playerName1, 1, reader);
  var player2 = new Player(playerName2, -1, reader);
  this.players = [player1, player2];
  this.winState = [0,0,0,0,0,0,0,0];
  this.board = new Board();
};

Game.prototype.run = function (completionCallback) {
  var that = this;
  that.board.print();
  this.currentPlayer().promptMove(function callback(row, col) {
    if (that.move(row, col)) {
      if (that.isOver()) {
        that.board.print();
        completionCallback(that.winner());
      } else {
        that.swapPlayers();
        that.board.print();
        that.currentPlayer().promptMove(callback);
      }
    } else {
      console.log("Invalid move! Please enter again");

      that.board.print();
      that.currentPlayer().promptMove(callback);
    }
  });
};

Game.prototype.currentPlayer = function () {
  return this.players[0];
};

Game.prototype.swapPlayers = function () {
  this.players.unshift(this.players.pop());
};

Game.prototype.move = function (row, col) {
  if (this.isValidMove(row,col)) {
    this.board.grid[row][col] = this.currentPlayer().piece;
    this.updateWinState(row,col);
    return true;
  }
  return false;
};

Game.prototype.updateWinState = function (row,col) {
  var piece = this.board.grid[row][col];
  this.winState[row] += piece;
  this.winState[col + 3] += piece;
  if (row === col) { this.winState[6] += piece;}
  if (row + col === 2) { this.winState[7] += piece;}
};

Game.prototype.isValidMove = function (row, col) {
  return this.board.grid[row][col] === 0;
};

Game.prototype.isWon = function () {
  return this.winState.some(function(el) {
    return el === 3 || el === -3;
  });
};

Game.prototype.isOver = function () {
  return this.isWon() || this.isTied();
};

Game.prototype.isTied = function () {
  return !this.board.grid.some(function(row) {
    return row.some(function(tile) {
      return tile === 0;
    });
  });
};

Game.prototype.winner = function () {
  if (this.isTied()) { return false; }
  if (this.isWon()) { return this.currentPlayer().name; }
};
module.exports = Game;
