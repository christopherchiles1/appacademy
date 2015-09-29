(function () {
  if (typeof Asteroids === 'undefined') {
    window.Asteroids = {};
  }

  var Util = window.Asteroids.Util = {};

  Util.inherits = function (child, parent) {
    function Surrogate () {}
    Surrogate.prototype = parent.prototype;
    child.prototype = new Surrogate();
    child.prototype.constructor = child;
  };

  Util.randomVec = function(length) {
    var randVector = [Math.random() * 2 - 1, Math.random() * 2 - 1];
    var dist = Util.distance([0,0], randVector);
    return (randVector.map( function(el) {
      return el * length / dist;
    }));
  };

  Util.distance = function(pos1, pos2) {
    return Math.sqrt((pos2[0] - pos1[0])*(pos2[0] - pos1[0]) +
    (pos2[1] - pos1[1])*(pos2[1] - pos1[1]));
  };
})();
