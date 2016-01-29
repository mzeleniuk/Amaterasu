toastr.options = {
  "closeButton": true,
  "debug": false,
  "progressBar": true,
  "preventDuplicates": false,
  "positionClass": "toast-top-right",
  "onclick": null,
  "showDuration": "400",
  "hideDuration": "1000",
  "timeOut": "7000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
};

$(function () {
  $(document).idleTimer(600000); // 10 minutes
});

$(function () {
  $(document).on("idle.idleTimer", function (event, elem, obj) {
    toastr.options = {
      "timeOut": "0"
    };

    toastr.info('It seems you are not active for more than 10 minutes.', 'Taking a little break?');
    $('.custom-alert').fadeIn();
    $('.custom-alert-active').fadeOut();
  });

  $(document).on("active.idleTimer", function (event, elem, obj, triggerevent) {
    toastr.options = {
      "closeButton": true,
      "progressBar": true,
      "timeOut": "7000"
    };

    toastr.clear();
    $('.custom-alert').fadeOut();
    toastr.success('Great that you decided to come back.', 'You are back!');
  });
});
