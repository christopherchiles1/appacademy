(function(root) {
  'use strict';

  var ApiUtil = root.ApiUtil = {
    fetchAllPokemons: function () {
      $.get("/api/pokemon", function (pokemons) {
        ApiActions.receiveAllPokemons(pokemons);
      });
    },

    fetchSinglePokemon: function (id) {
      $.get("/api/pokemon/" + id, function (pokemon) {
        ApiActions.receiveSinglePokemon(pokemon);
      });
    }
  };
}(this));
