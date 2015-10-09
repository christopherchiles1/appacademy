(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }

  root.BenchBnBApp.AppDispatcher = new FluxDispatcher();
}(this));
