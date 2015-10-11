(function () {

  if ( typeof window.Widgets === 'undefined') {
    window.Widgets = {};
  }

  var React = window.React;

  var WeatherClock = window.Widgets.WeatherClock =
  React.createClass({
    getInitialState: function () {
      return {currentTime: new Date()};
    },
    componentDidMount: function() {
      this.tickId = setInterval(this._tick,1000);
    },
    componentWillUnmount: function () {
      clearInterval(this.tickId);
    },
    _tick: function () {
      this.setState({currentTime: new Date()});
    },
    render: function () {
      return (
        <div className="weather-clock">
          <h3>{this.state.currentTime.toString().slice(0,25)}</h3>
          <Weather />
        </div>
      );
    }
  });

  var Weather = window.Widgets.WeatherClock = React.createClass({
    // api.openweathermap.org/data/2.5/weather?lat=35&lon=139

    componentDidMount: function () {
      var position;
       navigator.geolocation.getCurrentPosition(function(pos) {
        this.setWeatherState({lat: pos.coords.latitude, long: pos.coords.longitude});
      }.bind(this));

    },
    setWeatherState: function (posObject) {
      var request = new XMLHttpRequest();
      request.open('GET',
                   'http://api.openweathermap.org/data/2.5/weather?lat=' +
                   posObject.lat.toFixed(0) + '&lon=' +
                   posObject.long.toFixed(0),
                   true);

      request.onload = function() {
        if (request.status >= 200 && request.status < 400) {
          // Success!
          var resp = request.responseText;
          this.setState({weather: JSON.parse(resp)});
        } else {
          // We reached our target server, but it returned an error
          alert("Weather API could not be reached.");
        }
      }.bind(this);

      request.send();
    },
    getInitialState: function () {
      return {weather: null};
    },
    render: function () {
      var weatherText = "Fetching Weather...";
      if (this.state.weather) {
        weatherText = ('Your location is: ' + this.state.weather.name + '. ') +
                      this.state.weather.weather[0].description +
                      ', and the temperature is ' + this.state.weather.main.temp;
      }
      return (
        <h3>
          {weatherText}
        </h3>
      );
    }
  });

  React.render(
    <WeatherClock />,
    document.getElementById('weather-widget')
  );
})();
