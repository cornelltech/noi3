$(document).ready(function() {

  // PROJECTS DROPDOWN
  $('body').on('change', '#project_category_ids', function() {
    var category_id = $('#project_category_ids').val(); 
    $.ajax({
      method: 'GET',
      url: '/update_subcategory_dropdown',
      dataType: 'script',
      data: { 'category_id': category_id}
    }).done(function(data) {
      console.log(data);
    }).error(function(err) {
      console.log(err);
    });
  });


});