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
    },

    _updateBenches: function () {
      this.setState({ benches: BenchBnBApp.BenchStore.all() });
    },

    render: function () {
      var items;
      if (this.state.benches.length === 0) {
        items = <div className="indexItem">Nothing to see here...</div>;
      } else {
        items = this.state.benches.map(function (bench) {
          return <BenchBnBApp.IndexItem
            key={bench.id}
            bench={bench} />;
        });
      }
      return (
        <div>
          <div className="index">
            {items}
          </div>
        </div>
      );
    }
  });
})(this);
