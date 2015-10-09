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

  BenchBnBApp.BenchStore = $.extend({}, EventEmitter.prototype, {
    // NOTE: The BenchStore public API should only have getters
    all: function () {
      return _benches.slice();
    },
    dispatcherId: BenchBnBApp.AppDispatcher.register(function (payload) {
      if (payload.actionType === BenchBnBApp.BenchConstants.BENCHES_RECEIVED) {
        _resetBenches(payload.benches);
      }
    })
  });

})(this);
