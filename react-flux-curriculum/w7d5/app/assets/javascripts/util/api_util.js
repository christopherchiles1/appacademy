(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.ApiUtil = {
    fetchBenches: function (bounds) {
      $.ajax({
        url: "/api/benches",
        data: bounds,
        success: function (benches) {
          BenchBnBApp.ApiActions.receiveAll(benches);
        },
        error: function (benches_errors) {
          alert('Benches Failed to Load'); // TODO: make a better error callback
        }
      });
    }
  };
})(this);
