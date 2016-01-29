$.rails.allowAction = function (link) {
  if (!link.attr('data-confirm')) {
    return true;
  }

  $.rails.showConfirmDialog(link);

  return false;
};

$.rails.confirmed = function (link) {
  link.removeAttr('data-confirm');

  return link.trigger('click.rails');
};

$.rails.showConfirmDialog = function (link) {
  var message;
  message = link.attr('data-confirm');

  return swal({
    title: message,
    text: '',
    type: "warning",
    showCancelButton: true,
    confirmButtonColor: "#DD6B55",
    confirmButtonText: "Yes, delete it!",
    closeOnConfirm: false,
    html: false
  }, function () {
    $.rails.confirmed(link);
    return swal("Deleted!", "", "success");
  });
};
