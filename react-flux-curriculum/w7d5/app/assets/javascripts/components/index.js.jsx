(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.Index = React.createClass({
    getInitialState: function () {
      return { benches: BenchBnBApp.BenchStore.all() };
    },

    componentDidMount: function () {
      BenchBnBApp.BenchStore.addChangeListener(this._updateBenches);
      BenchBnBApp.ApiUtil.fetchBenches();
    },

    _updateBenches: function () {
      this.setState({ benches: BenchBnBApp.BenchStore.all() });
    },

    render: function () {
      return (
        // NOTE: Change this Rendering!!!
        <div>{this.state.benches.toString()}</div>
      );
    }
  });
})(this);
