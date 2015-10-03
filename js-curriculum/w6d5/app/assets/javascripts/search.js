$.UsersSearch = function(el) {
  this.$el = $(el);
  this.$usersList = this.$el.find('.users');
  this.$input = this.$el.find('.query');

  this.$input.on('keyup', this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function(e) {
  var formData = this.$input.val();
  $.ajax({
    url: 'search',
    type: 'get',
    dataType: 'json',
    data: {
      query: formData
    },
    success: function(results) {
      console.log(results);
      this.renderResults(results);
    }.bind(this)
  });
};

$.UsersSearch.prototype.renderResults = function (results) {
  var templateCode = $(".users-template").html();
  var templateFn = _.template(templateCode);
  var rendered = templateFn({results: results});
  this.$usersList.html(rendered);
  this.$usersList.find(".follow-toggle").followToggle();
};

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $(".users-search").usersSearch();
});
