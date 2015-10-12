(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  var _benches = [];
  var _resetBenches = function (benches) {
    _benches = benches;
  };

  var CHANGE_EVENT = "CHANGE_EVENT";

  BenchBnBApp.BenchStore = $.extend({}, EventEmitter.prototype, {
    // NOTE: The BenchStore public API should only have getters
    all: function () {
      return _benches.slice();
    },
    addChangeListener: function (callback) {
      this.addListener(CHANGE_EVENT, callback);
    },
    removeChangeListener: function (callback) {
      this.removeListener(CHANGE_EVENT, callback);
    },
    dispatcherId: BenchBnBApp.AppDispatcher.register(function (payload) {
      if (payload.actionType === BenchBnBApp.BenchConstants.BENCHES_RECEIVED) {
        _resetBenches(payload.benches);
        BenchBnBApp.BenchStore.emit(CHANGE_EVENT);
      }
    })
  });
})(this);
