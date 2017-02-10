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

  var adviseCategories = ["#advise-open-data", "#advise-data-science", "#advise-prizes"]
  var adviseLessCategories = ["#advise-less-open-data", "#advise-less-data-science", "#advise-less-prizes"]

  adviseCategories.forEach(function(category) {
    $(category).click(function() {
      $(this).data('clicked', true);

      if($(this).data('clicked')) {
        console.log(category, 'clicked')
        $(this).find("#advise-view-more").hide();
        $(this).find("#advise-all-skills").toggleClass("advise-view-less");
      };
    })
  })

  // adviseLessCategories.forEach(function(category) {
  //   $(category).click(function() {
  //     $(this).data('clicked', true);
  //     console.log(category, 'clicked')
  //
  //     // if($(this).data('clicked')) {
  //     //   $(this).next("#advise-all-skills").toggleClass("advise-view-less");
  //     //   $(this).next("#advise-view-more").show();
  //     // };
  //   })
  // })

  // $(category).next("#advise-view-less").click(function() {
  //   console.log(category, 'advise clicked')
  //   // $(this).next("#advise-all-skills").toggleClass("advise-view-less");
  //   // $(this).next("#advise-view-more").show();
  // })

  // $("#advise-view-more").click(function() {
  //   console.log("clicked")
  //   $(this).hide();
  //   $("#advise-all-skills").toggleClass("advise-view-less");
  // })

  // $("#advise-view-less").click(function() {
  //   $("#advise-all-skills").toggleClass("advise-view-less");
  //   $("#advise-view-more").show();
  // })

});
