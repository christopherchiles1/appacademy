(function(root) {
  'use strict';

  var _pokemons = [];

  var _resetPokemons = function (pokemons) {
    _pokemons = pokemons;
    PokemonStore.emit(PokemonStore.POKEMONS_INDEX_CHANGE_EVENT);
  };

  var _storeSinglePoke = function (pokemon) {
    var oldPoke = PokemonStore.find(pokemon.id);
    var idx = _pokemons.indexOf(oldPoke);
    _pokemons.splice(idx, 1, pokemon);
    PokemonStore.emit(PokemonStore.POKEMON_DETAIL_CHANGE_EVENT);
  };

  root.PokemonStore = $.extend({}, EventEmitter.prototype, {
    POKEMONS_INDEX_CHANGE_EVENT: 'POKEMONS_INDEX_CHANGE_EVENT',
    POKEMON_DETAIL_CHANGE_EVENT: 'POKEMON_DETAIL_CHANGE_EVENT',

    all: function () {
      return _pokemons.slice();
    },


    find: function (id) {
      return _pokemons.filter(function (el) {
        return el.id === id;
      })[0];
    },

    dispatcherID: AppDispatcher.register(function (payload) {
      switch (payload.actionType) {
        case PokemonConstants.POKEMONS_RECEIVED:
          _resetPokemons(payload.pokemons);
          break;
        case PokemonConstants.SINGLE_POKEMON_RECEIVED:
          _storeSinglePoke(payload.pokemon);
          break;
      }
    })
  });
}(this));
