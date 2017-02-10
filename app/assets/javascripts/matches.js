$(document).ready(function() {

  var categories = ["#open-data", "#data-science", "#prizes", "#citizen-science", "#advise-open-data", "#advise-data-science", "#advise-prizes", "#advise-citizen-science"]

  categories.forEach(function(category) {
    $(category).click(function() {
      $(this).data('clicked', true);
      var show = false;

      if($(this).data('clicked')) {
        $(this).find("#advise-view-more").toggleClass("advise-view-less");
        $(this).find(".advise-all-skills").toggleClass("advise-view-less");

        var allSkills = $(this).find("#advise-all-skills");

        if (allSkills.data('clicked')) {
          var show = true
          $(this).find("#advise-view-more").toggleClass("advise-view-less");
          if(show) {
            $(this).find("#advise-view-more").toggleClass("advise-view-less")
          }
        }
      };
    })
  })
});
