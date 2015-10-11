$(function(root) {
  'use strict';

  root.PokemonDetail = React.createClass({
    getInitialState: function () {
      return ({ pokemon: this.getStateFromStore(this.props.params.pokemonId)});
    },

    getStateFromStore: function (id) {
      id = parseInt(id);
      return PokemonStore.find(id);
    },

    _updateDetail: function () {
      this.setState({ pokemon: this.getStateFromStore(this.props.params.pokemonId) });
    },

    componentDidMount: function () {
      PokemonStore.addListener(PokemonStore.POKEMON_DETAIL_CHANGE_EVENT, this._updateDetail);
    },

    componentWillReceiveProps: function (newProps) {
      ApiUtil.fetchSinglePokemon(newProps.params.pokemonId);
    },

    render: function () {
      var pokemon = this.state.pokemon;

      return (
        (pokemon) ?
          <div className="detail">
            <img src={pokemon.image_url}></img>
            Name: {pokemon.name}
            <hr/>
            Type: {pokemon.poke_type}
            <hr/>
            Attack: {pokemon.attack}
            <hr/>
            Defense: {pokemon.defense}
            <hr/>
            Moves:
            {
              pokemon.moves.map(function (move) {
                return <li>{move}</li>;
              })
            }
          </div> :
          <div></div>
      );
    }
  });

}(this));
