$(document).ready(function() {

  function setCookie(cname, cvalue) {
    document.cookie = cname + "=" + cvalue + ";";
  };

  $(".match-me-toast i").click(function() {
    setCookie("matchesBanner", "true")
  });

  $(".main-toast i").click(function() {
    setCookie("mainBanner", "true")
  });

  function checkForMatchesToast() {
    var mainMatchesBanner = getCookie("matchesBanner")

    if ( mainMatchesBanner === "true" ) {
      $(".match-me-toast").css("display", "none");
    }
  };

  function checkForMainToast() {
    var mainToastBanner = getCookie("mainBanner");

    if ( mainToastBanner === "true")  {
      $(".main-toast").css("display", "none");
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
