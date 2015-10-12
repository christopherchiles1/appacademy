(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.Search = React.createClass({
    render: function () {
      return (
        <div>
          <BenchBnBApp.Map />
          <BenchBnBApp.Index />
        </div>
      );
    }
  });
})(this);
