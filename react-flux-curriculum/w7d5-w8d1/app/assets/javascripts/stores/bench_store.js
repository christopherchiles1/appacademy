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

  var _updateBench = function (newBench) {
    var bench = _benches.find(function (b) {
      return b.id === bench.id;
    });
    if (bench) {
      _benches.splice(_benches.indexOf(bench), 1, newBench);
    } else {
      _benches.push(bench);
    }
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
      switch (payload.actionType) {
        case BenchBnBApp.BenchConstants.BENCHES_RECEIVED:
          _resetBenches(payload.benches);
          BenchBnBApp.BenchStore.emit(CHANGE_EVENT);
          break;
        case BenchBnBApp.BenchConstants.BENCH_RECEIVED:
          _updateBench(payload.bench);
          BenchBnBApp.BenchStore.emit(CHANGE_EVENT);
          break;
      }
    })
  });
})(this);
