(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.ApiUtil = {
    fetchBenches: function () {
      $.ajax({
        url: "/api/benches",
        success: function (benches) {
          BenchBnBApp.ApiActions.receiveAll(benches);
        }
      });
    }
  };
}(this));
