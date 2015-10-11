(function(root) {
  'use strict';

  root.PokemonsIndexItem = React.createClass({
    mixins: [ReactRouter.History],
    render: function () {
      return (
        <li
          className="poke-list-item"
          onClick={this._showDetail}>
          {this.props.name}
        </li>
      );
    },

    _showDetail: function () {
      this.history.pushState(null, "/pokemon/" + this.props.id);
    }
  });
}(this));
