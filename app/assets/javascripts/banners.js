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
    console.log(username)

    if ( username == "guest" ) {
      console.log("you are guest")
    } else {
      console.log("you are NOT a guest")
      checkForMainToast();
      checkForMatchesToast();
    }
  }

  checkForUser();

});
