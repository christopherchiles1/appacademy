(function () {
  if (typeof window.Minesweeper === "undefined") {
    window.Minesweeper = {};
  }
  var React = window.React;

  var Game = window.Minesweeper.Game =
  React.createClass({
    getInitialState: function () {
      return {
        board: new window.Minesweeper.Board(10, 4),
        gameOver: false,
        gameWon: false
      };
    },
    updateGame: function (pos, e) {

      this.state.board.grid[pos[0]][pos[1]].explore();
      this.forceUpdate();
    },
    render: function () {
      return <Board board={this.state.board} onUpdateGame={this.updateGame}/>;
    }
  });

  var Board = window.Minesweeper.Game.Board =
  React.createClass({
    render: function () {
      var tiles = [];
      var size = this.props.board.gridSize;
      var numTimes = Math.pow(size, 2);
      for (var i = 0; i < numTimes; i++){
        var row = Math.floor(i / size);
        var col = i % size;
        tiles.push(
          <Tile
            pos={[row, col]}
            onUpdateGame={this.props.onUpdateGame} />
        );
      }

      return (
        <div className="board-tiles">
          {tiles}
        </div>
      );
    }
  });

  var Tile = window.Minesweeper.Game.Tile =
  React.createClass({
    getInitialState: function () {
      return {bombed: false,
              flagged: false,
              explored: false};
    },
    handleClick: function (e) {
      console.log(this.props.pos);
      this.props.onUpdateGame(this.props.pos);
    },
    render: function () {
      if (this.state.flagged) {
        return <div className="tile flagged" onClick={this.handleClick} ></div>;
      } else if (this.state.explored) {
        return <div className="tile explored" onClick={this.handleClick}></div>;
      } else {
        return <div className="tile" onClick={this.handleClick} ></div>;
      }
    }
  });

  React.render(
    <Game />,
    document.getElementById('game-container')
  );

})();
