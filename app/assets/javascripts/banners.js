$(document).ready(function() {

  var x = document.cookie;
  console.log(x);

  $(".toast i").click(function() {
    document.cookie = "matchMeToast=true";
    console.log(x);
  })

  var checkForToast = function() {
    if ( document.cookie.indexOf("matchMeToast=true") ) {
      $(".toast").css("display", "none");
      console.log("has matchMeToast!!")
    };
  };

  checkForToast();

});
