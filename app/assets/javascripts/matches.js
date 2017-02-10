$(document).ready(function() {

  $("#view-more").click(function() {
    $(this).hide();
    $("#all-skills").toggleClass("view-less");
  })

  $("#view-less").click(function() {
    $("#all-skills").toggleClass("view-less");
    $("#view-more").show();
  })


  // Advise
  
  $("#advise-view-more").click(function() {
    $(this).hide();
    $("#advise-all-skills").toggleClass("advise-view-less");
  })

  $("#advise-view-less").click(function() {
    $("#advise-all-skills").toggleClass("advise-view-less");
    $("#advise-view-more").show();
  })

});
