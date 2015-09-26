function Clock () {
  this.currentTime;
  this.seconds;
  this.minutes;
  this.hours;
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  console.log(
              this.currentTime.getHours() + "::" +
              this.currentTime.getMinutes() + "::" +
              this.currentTime.getSeconds()
            );
  // Format the time in HH:MM:SS
};

Clock.prototype.run = function () {
  this.currentTime = new Date();
  this.printTime();
  var that = this;
  var callback = function() {
    that._tick();
  };
  setInterval(callback, Clock.TICK);
  // setInterval(that._tick.bind(that), Clock.TICK);
  // setInterval(function () {
  //   that._tick();
  // }, Clock.TICK);

  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  this.currentTime.setSeconds(this.currentTime.getSeconds()+ 5);
  this.printTime();
};

var clock = new Clock();
clock.run();
