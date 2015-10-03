(function ($){
  $.Carousel = function (el) {
    this.$el = $(el);
    this.activeIdx = 0;
    this.$listItems = this.$el.find("ul.items").children();
    this.$activeImg = this.$listItems.eq(0).addClass("active");
    this.transitioning = false;
    this.bindEvents();
  };

  $.Carousel.prototype.bindEvents = function () {
    var slideRight = function (e) {
      e.preventDefault();
      if (this.transitioning) { return; }
      this.transitioning = true;
      var listLength = this.$listItems.length;
      this.activeIdx = ((this.activeIdx + 1 + listLength) % listLength);
      var $nextActiveImg = this.$listItems.eq(this.activeIdx);

      $nextActiveImg.addClass("left");
      $nextActiveImg.addClass("active");
      this.$activeImg.addClass("right"); // triggers a transition
      setTimeout(function () {
        $nextActiveImg.removeClass("left"); // triggers a transition
      }.bind(this), 0);

      this.$activeImg.one("transitionend", function (e) {
        $(e.currentTarget).removeClass("active right");
        this.transitioning = false;
      }.bind(this));

      this.$activeImg = $nextActiveImg;
    };

    var slideLeft = function (e) {
      e.preventDefault();
      if (this.transitioning) { return; }
      this.transitioning = true;
      var listLength = this.$listItems.length;
      this.activeIdx = ((this.activeIdx + -1 + listLength) % listLength);
      var $nextActiveImg = this.$listItems.eq(this.activeIdx);

      $nextActiveImg.addClass("right");
      $nextActiveImg.addClass("active"); // triggers a transition
      this.$activeImg.addClass("left"); // triggers a transition
      setTimeout(function () {
        $nextActiveImg.removeClass("right");
      }.bind(this), 0);

      this.$activeImg.one("transitionend", function (e) {
        $(e.currentTarget).removeClass("active left");
        this.transitioning = false;
      }.bind(this));

      this.$activeImg = $nextActiveImg;
    };

    //  var slide = function (dir) {
    //
    //  };

    $(".slide-left").on("click", slideLeft.bind(this));
    $(".slide-right").on("click", slideRight.bind(this));
  };


  $.fn.carousel = function () {
    return this.each(function ($el) {
      new $.Carousel(this);
    });
  };
})(jQuery);
