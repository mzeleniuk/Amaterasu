jQuery(function () {
  if ($('#infinite-scroll').size() > 0) {
    $(window).on('scroll', function () {
      var more_url;
      more_url = $('.pagination .next_page a').attr('href');

      if (more_url && $(window).scrollTop() > $(document).height() - $(window).height() - 500) {
        $('.pagination').html('<p>Loading...</p>');
        $.getScript(more_url);
      }
    });
  }
});
