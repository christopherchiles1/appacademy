(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.Map = React.createClass({
    _createMap: function () {
      var map = React.findDOMNode(this.refs.map);
      var mapOptions = {
        center: {lat: 37.7758, lng: -122.435},
        zoom: 13
      };
      this.map = new root.google.maps.Map(map, mapOptions);
    },

    _updateBenches: function () {
      var benches = BenchBnBApp.BenchStore.all();
      // Add markers to Map may need to be an ivar
      var markers = benches.map(function (bench) {
        return (
          new root.google.maps.Marker({
            position: {lat: bench.lat, lng: bench.lon},
            map: this.map,
            title: 'Hello World!' // TODO: change this
          })
        );
      }.bind(this));
    },

    componentDidMount: function(){
      this._createMap();
      this.map.addListener('idle', BenchBnBApp.ApiUtil.fetchBenches);
      BenchBnBApp.BenchStore.addChangeListener(this._updateBenches);
    },

    render: function () {
      return (
        <div className="map" ref="map"></div>
      );
    }
  });
})(this);
