(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.Map = React.createClass({
    componentDidMount: function(){
      this.benches = [];
      this.markers = [];
      this._createMap();
      this._setMapIdleHandler();
      BenchBnBApp.BenchStore.addChangeListener(this._updateBenches);
    },

    _updateBenches: function () {
      // grab a copy of the old benches
      var oldBenches = this.benches.slice();
      // get the new benches from the Store
      this.benches = BenchBnBApp.BenchStore.all();

      var newBenches = _benchDiff(this.benches, oldBenches);
      var trashBenches = _benchDiff(oldBenches, this.benches);

      // Add the new markers
      newBenches.forEach(function (bench) {
        this._addMarker(bench);
      }.bind(this));

      // Remove the old markers
      trashBenches.forEach(function (bench) {
        this._removeMarker(bench);
      }.bind(this));
    },

    render: function () {
      return (
        <div className="map" ref="map"></div>
      );
    },

    // Google Maps Handling
    _createMap: function () {
      var map = React.findDOMNode(this.refs.map);
      var mapOptions = {
        center: {lat: 37.7758, lng: -122.435},
        zoom: 13
      };
      this.map = new root.google.maps.Map(map, mapOptions);
    },

    _setMapIdleHandler: function () {
      this.map.addListener('idle', this._onMapIdle);
    },

    _onMapIdle: function () {
      var mapBounds = this.map.getBounds();
      var ne = mapBounds.getNorthEast();
      var sw = mapBounds.getSouthWest();
      var bounds = {
          northEast: { lat: ne.lat(), lng: ne.lng()},
          southWest: { lat: sw.lat(), lng: sw.lng() }
      };
      BenchBnBApp.ApiUtil.fetchBenches({ bounds: bounds });
    },

    _addMarker: function (bench) {
      var marker = new root.google.maps.Marker({
        position: {lat: bench.lat, lng: bench.lon},
        map: this.map,
        title: 'Hello World!' // TODO: change this
      });
      this.markers.push([bench.id, marker]);
    },

    _removeMarker: function (bench) {
      var marker = this.markers.find(function (marker) {
        return (marker[0] === bench.id);
      });

      var idx = this.markers.indexOf(marker);
      marker[1].setMap(null);
      this.markers.splice(idx, 1);
    }
  });

  // benchDiff returns all benches in benches1 that arent in benches2
  function _benchDiff(benches1, benches2) {
    var diff = benches1.filter(function (item1) {
      var included = false;
      benches2.forEach(function (item2) {
        if (item1.id === item2.id) {
          included = true;
        }
      });
      return !included;
    });
    return diff;
  }
})(this);
