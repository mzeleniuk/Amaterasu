// Back to Top link

$(document).ready(function () {
  $(function () {
    $(window).scroll(function () {
      if ($(this).scrollTop() > 300) {
        $('.back-top').fadeIn();
      } else {
        $('.back-top').fadeOut();
      }
    });

    $('.back-top').click(function () {
      $('body, html').animate({
        scrollTop: 0
      }, 800);
      return false;
    });
  });
});
