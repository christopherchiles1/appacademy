(function ($){
  $.Tabs = function (el) {
    this.$el = $(el);
    this.$contentTabs = $(this.$el.attr('data-content-tabs'));
    this.$activeTab = this.$el.find("li:first-child a");
    this.$activeTab.addClass('active');
    this.activeArticle().addClass('active');
    this.$el.on('click','a', this.clickTab.bind(this));
   };

   $.Tabs.prototype.activeArticle = function () {
     return this.$contentTabs.find(this.$activeTab.attr('href'));
   };

   $.Tabs.prototype.clickTab = function (e) {
     var that = this;
     var $activeArticle = this.activeArticle();

     $activeArticle.addClass('transitioning');
     $activeArticle.removeClass('active');
     this.$activeTab.removeClass('active');

     $activeArticle.one("transitionend", function () {
       $activeArticle.removeClass('transitioning');

       that.$activeTab = $(e.currentTarget);
       $activeArticle = that.activeArticle();

       that.$activeTab.addClass('active');

       $activeArticle.addClass('transitioning');
       setTimeout(function () {
         $activeArticle.addClass('active');
         $activeArticle.removeClass('transitioning');
       }, 0);
     });
   };

  $.fn.tabs = function () {
    return this.each(function ($el) {
      new $.Tabs(this);
    });
  };
})(jQuery);
