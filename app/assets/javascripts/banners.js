$(document).ready(function() {

  var x = document.cookie;
  console.log(x);


  $(".match-me-toast i").click(function() {
    document.cookie = "matchMeToast=true";
    console.log(x);
  })

  $(".main-toast i").click(function() {
    document.cookie = "mainToast=true";
    console.log(x);
  })

  var checkForMatchesToast = function() {
    if ( document.cookie.indexOf("matchMeToast=true") ) {
      $(".match-me-toast").css("display", "none");
    };
  };

  var checkForMainToast = function() {
    if ( document.cookie.indexOf("mainToast=true") ) {
      $(".main-toast").css("display", "none");
    };
  };

  checkForMainToast();
  checkForMatchesToast();

});
