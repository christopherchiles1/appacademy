(function(root) {
  'use strict';

  var ApiActions = root.ApiActions = {
    receiveAllPokemons: function (payload) {
      AppDispatcher.dispatch({
        actionType: PokemonConstants.POKEMONS_RECEIVED,
        pokemons: payload
      });
    },

    receiveSinglePokemon: function (payload) {
      AppDispatcher.dispatch({
        actionType: PokemonConstants.SINGLE_POKEMON_RECEIVED,
        pokemon: payload
      });
    }
  };
}(this));
