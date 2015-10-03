$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.data('user-id');
  this.followState = this.$el.data('initial-follow-state');
  this.render();
  this.handleClick();
};

$.FollowToggle.prototype.render = function () {
  var text;

  if (this.followState === "followed") {
    text = "Unfollow!";
    this.$el.prop("disabled", false);
  } else if (this.followState === "unfollowed") {
    text = "Follow!";
    this.$el.prop("disabled", false);
  }
  this.$el.text(text);
};

$.FollowToggle.prototype.handleClick = function () {
  this.$el.on("click", function (e) {
    e.preventDefault();
    this.$el.prop("disabled", true);
    var options = {
      url: this.userId + '/follow',
      dataType: 'json'
    };

    if (this.followState === "unfollowed") {
      this.followState = "following";
      $.extend(options, {
        type: 'post',
        success: function(responseData) {
          this.followState = "followed";
          this.render();
        }.bind(this),
        failure: function (responseData) {
          this.followState = "unfollowed";
        }.bind(this)
      });
    } else {
      this.followState = "unfollowing";
      $.extend(options, {
        type: 'delete',
        success: function(responseData) {
          this.followState = "unfollowed";
          this.render();
        }.bind(this),
        failure: function (responseData) {
          this.followState = "followed";
        }.bind(this)
      });
    }

    $.ajax(options);

  }.bind(this));
};

$.fn.followToggle = function () {
  return this.each(function () {
    new $.FollowToggle(this);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
