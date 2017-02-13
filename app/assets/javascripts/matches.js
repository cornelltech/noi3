$(document).ready(function() {

  var categories = ["#open-data", "#data-science", "#prizes", "#citizen-science", "#community-engagement", "#lab-design", "#crowdsourcing", "#rcts", "#advise-rcts", "#advise-crowdsourcing", "#advise-lab-design", "#advise-open-data", "#advise-data-science", "#advise-prizes", "#advise-citizen-science", "#advise-community-engagement"]

  categories.forEach(function(category) {
    $(category).click(function() {
      $(this).data('clicked', true);
      var show = false;

      if($(this).data('clicked')) {
        $(this).find("#view-more").toggleClass("view-less");
        $(this).find(".all-skills").toggleClass("view-less");

        var allSkills = $(this).find("#all-skills");

        if (allSkills.data('clicked')) {
          var show = true
          $(this).find("#view-more").toggleClass("view-less");
          if(show) {
            $(this).find("#view-more").toggleClass("view-less")
          }
        }
      };
    })
  })
});
