(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.BenchForm = React.createClass({
    getInitialState: function () {
      return {
        lat: 0,
        lon: 0,
        description: ""
      };
    },

    updateLatitude: function (e) {
      this.setState({lat: e.currentTarget.value.to_f});
    },

    updateLongitude: function (e) {
      this.setState({lon: e.currentTarget.value.to_f});
    },

    updateDescription: function (e) {
      this.setState({description: e.currentTarget.value});
    },

    handleSubmit: function (e) {
      e.preventDefault();
      // Send the bench to API utils
    },

    render: function () {
      return (
        <form className="bench-form" onSubmit={this.handleSubmit}>
          <label>Latitude: </label>
            <input
              onChange={this.updateLatitude}
              value={this.state.lat}></input>
          <label>Longitude: </label>
            <input
              onChange={this.updateLongitude}
              value={this.state.lon}></input>
          <label>Description: </label>
            <input
              onChange={this.updateDescription}
              value={this.state.description}></input>
            <br/>
          <button>Add Bench</button>
        </form>
      );
    }
  });
})(this);
