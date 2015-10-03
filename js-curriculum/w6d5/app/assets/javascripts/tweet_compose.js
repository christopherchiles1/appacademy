$.TweetCompose = function(el) {
  this.$el = $(el);
  this.submitHandler();
};

$.TweetCompose.prototype.submitHandler = function () {
  var that = this;

  this.$el.on("submit", function (e) {
    e.preventDefault();
    var formData = $(this).serialize();

    $.ajax({
      url: "/tweets",
      type: "POST",
      dataType: "json",
      data: formData,
      success: that.handleSuccess.bind(that),
      failure: function (results) {
        console.log(results + " :(");
      }
    });
  });
};

$.TweetCompose.prototype.handleSuccess = function (result) {
  var $tweetList = $(this.$el.data('tweets-ul'));
  debugger;
  $tweetList.append('<li>' + JSON.stringify(result) + '</li>');
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $(".tweet-compose").tweetCompose();
});
