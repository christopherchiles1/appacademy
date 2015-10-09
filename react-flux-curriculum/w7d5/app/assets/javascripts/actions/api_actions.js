(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.ApiActions = {
    receiveAll: function (benches) {
      BenchBnBApp.AppDispatcher.dispatch({
        actionType: BenchBnBApp.BenchConstants.BENCHES_RECEIVED,
        benches: benches
      });
    }
  };
}(this));
