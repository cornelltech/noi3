$(document).ready(function() {

  // $("#view-more").click(function() {
  //   $(this).hide();
  //   $("#all-skills").toggleClass("view-less");
  // })
  //
  // $("#view-less").click(function() {
  //   $("#all-skills").toggleClass("view-less");
  //   $("#view-more").show();
  // })


  // Advise

  var adviseCategories = ["#advise-open-data", "#advise-data-science", "#advise-prizes"]
  var adviseLessCategories = ["#advise-less-open-data", "#advise-less-data-science", "#advise-less-prizes"]

  adviseCategories.forEach(function(category) {
    $(category).click(function() {
      $(this).data('clicked', true);

      if($(this).data('clicked')) {
        console.log(category, 'clicked')
        $(this).find("#advise-view-more").toggleClass("advise-view-less");
        $(this).find(".advise-all-skills").toggleClass("advise-view-less");
      };
    })
  })

  adviseLessCategories.forEach(function(elm) {
    $(elm).click(function() {
      $(this).data('clicked', true);

      if($(this).data('clicked')) {
        $(this).find("#advise-all-skills").toggleClass("advise-view-less");
        $(this).find("#advise-view-more").toggleClass("advise-view-less");
      };
    })
  })

});
