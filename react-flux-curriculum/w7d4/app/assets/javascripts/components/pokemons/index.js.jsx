$(function(root) {
  'use strict';

  root.PokemonsIndex = React.createClass({
    getInitialState: function () {
      return { pokemons: PokemonStore.all() };
    },

    componentDidMount: function () {
      ApiUtil.fetchAllPokemons();
      PokemonStore.addListener(
        PokemonStore.POKEMONS_INDEX_CHANGE_EVENT, this._onChange
      );
    },

    componentWillUnmount: function () {
      PokemonStore.removeListener(
        PokemonStore.POKEMONS_INDEX_CHANGE_EVENT, this._onChange
      );
    },

    render: function () {
      var that = this;
      var pokemonsList = function () {
        return that.state.pokemons.map(function (pok) {
          return <PokemonsIndexItem {...pok} />;
        });
      }();

      return (
        <ul>
          {pokemonsList}
        </ul>
      );
    },

    _onChange: function () {
      this.setState({ pokemons: PokemonStore.all() });
    }
  });
}(this));
