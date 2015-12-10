// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require pace/pace.min.js
//= require toastr/toastr.min.js
//= require idle-timer/idle-timer.min.js
//= require turbolinks
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.fr.js
//= require_tree .

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
    // function you want to fire when the user goes idle

    toastr.options = {
      "timeOut": "0"
    };

    toastr.info('It seems you are not active for more than 10 minutes.', 'Taking a little break?');
    $('.custom-alert').fadeIn();
    $('.custom-alert-active').fadeOut();
  });

  $(document).on("active.idleTimer", function (event, elem, obj, triggerevent) {
    // function you want to fire when the user becomes active again

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
