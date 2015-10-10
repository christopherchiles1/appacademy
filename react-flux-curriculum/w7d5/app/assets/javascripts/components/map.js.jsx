(function(root) {
  'use strict';
  if (typeof root.BenchBnBApp === "undefined") {
    root.BenchBnBApp = {};
  }
  var BenchBnBApp = root.BenchBnBApp;

  BenchBnBApp.Map = React.createClass({
    getInitialState: function () {
      this._createMap();
      this.markers = [];
      this.benchIds = [];
    },

    componentDidMount: function(){
      this._setMapIdleHandler();
      BenchBnBApp.BenchStore.addChangeListener(this._updateBenches);
    },

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

    _updateBenches: function () {
      var benches = BenchBnBApp.BenchStore.all();

      var markers = [];
      _addedBenches.forEach(function (bench) {
        _addMarker(bench);
      });
      _removedBenches.forEach(function (bench) {
        _removeMarker(bench);
      });

      this.oldBenches = benches;
    },

    _addedBenches: function (oldList, newList) {
      var added = newList.filter(function (bench) {
        var included = false;
        oldList.forEach(function (oldBench) {
          if (bench.id === oldBench.id) {
            included = true;
          }
        });
        return !included;
      });
      console.log(added);
    },

    _removedBenches: function (oldList, newList) {
      // TODO: Get marker filtering to work!!!
    },

    _addMarker: function (bench) {
      var marker = new root.google.maps.Marker({
        position: {lat: bench.lat, lng: bench.lon},
        map: this.map,
        title: 'Hello World!' // TODO: change this
      });
      this.markers.push([board.id, marker]);
    },

    _removeMarker: function (board) {
      var marker = this.markers.find(function (marker) {
        return marker[0] === board.id;
      });
      var idx = this.markers.indexOf(marker);
      this.markers.slice(idx, 1);
      marker.setMap(null);
    },

    render: function () {
      return (
        <div className="map" ref="map"></div>
      );
    }
  });
})(this);
