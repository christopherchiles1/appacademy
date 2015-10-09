$(function () {

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
        <div>{this.state.benches}</div>
      );
    }
  });

  // Render the top-level React component
  React.render(
    <BenchBnBApp.Index />,
    document.getElementById("content")
  );
});
