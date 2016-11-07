$(document).ready(function() {
  var username = "";
  var data;

  var grabData = function() {
    $.getJSON('https://discuss.networkofinnovators.org/notifications.json?username=' + username, function(apiData) {
      data = apiData;
    });
  };

  grabData();
})
