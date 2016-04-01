jQuery(function () {
  if ($('#infinite-scroll').size() > 0) {
    $(window).on('scroll', function () {
      var more_url;
      more_url = $('.pagination .next_page a').attr('href');

      if (more_url && $(window).scrollTop() > $(document).height() - $(window).height() - 500) {
        $('.pagination').html(
          '<div class="progress progress-striped active" style="width: 50%; margin-left: 25%;">' +
          '  <div class="bar" style="width: 100%;"></div>' +
          '</div>'
        );
        $.getScript(more_url);
      }
    });
  }
});
