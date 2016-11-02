$(document).ready(function() {
  var cookies = document.cookie;
  cookies += "matchMeToast=false";
  cookies += "mainToast=false";
  // console.log(cookies);

  $(".match-me-toast i").click(function() {
    cookies += "matchMeToast=true";
    // console.log(cookies)
  });

  $(".main-toast i").click(function() {
    cookies += "mainToast=true";
    // console.log(cookies)
  });

  function checkForMatchesToast() {
    if ( cookies.indexOf("matchMeToast=true") ) {
      $(".match-me-toast").css("display", "none");
      // console.log("match cookie exists")
    }
  };

  function checkForMainToast() {
    if ( cookies.indexOf("mainToast=true") ) {
      $(".main-toast").css("display", "none");
      // console.log("main cookie exists")
    }
  };

  function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length,c.length);
        }
    }
    return "";
  }

  function checkForUser() {
    var username = getCookie("username");

    if ( username !== "guest" ) {
      checkForMainToast();
      checkForMatchesToast();
    }
  };

  checkForUser();

});
