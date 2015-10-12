(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.IndexItem = React.createClass({
    render: function () {
      return (
        <div className="indexItem">
          {
            this.props.bench.description
          }
        </div>
      );
    }
  });
})(this);
