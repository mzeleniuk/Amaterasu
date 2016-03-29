$(function () {
  var canvas, ctx, doughnutData, doughnutOptions, percentage;

  doughnutOptions = {
    segmentShowStroke: true,
    segmentStrokeColor: "#fff",
    segmentStrokeWidth: 2,
    percentageInnerCutout: 45,
    animationSteps: 100,
    animationEasing: "easeOutBounce",
    animateRotate: true,
    animateScale: false,
    responsive: true,
    showTooltips: false
  };

  if ($('#profile-strength-pie-chart').length) {
    canvas = $('#profile-strength-pie-chart');
    percentage = 0;

    if (canvas.data('first_name')) {
      percentage += 10;
    }
    if (canvas.data('last_name')) {
      percentage += 10;
    }
    if (canvas.data('email')) {
      percentage += 20;
    }
    if (canvas.data('gender')) {
      percentage += 5;
    }
    if (canvas.data('date_of_birth')) {
      percentage += 10;
    }
    if (canvas.data('country')) {
      percentage += 10;
    }
    if (canvas.data('city')) {
      percentage += 10;
    }
    if (canvas.data('phone_number')) {
      percentage += 10;
    }
    if (canvas.data('bio')) {
      percentage += 15;
    }

    doughnutData = [
      {
        value: percentage,
        color: "#A4CEE8",
        highlight: "#1ab394"
      }, {
        value: 100 - percentage,
        color: "#dedede",
        highlight: "#1ab394"
      }
    ];

    ctx = canvas[0].getContext("2d");
    return new Chart(ctx).Doughnut(doughnutData, doughnutOptions);
  }
});
