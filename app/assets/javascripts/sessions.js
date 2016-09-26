$(document).ready(function() {
  // SESSIONS#NEW
  $('#login_submit').on('click', function(e) {
    e.preventDefault();
    var email = $('#user_email').val();
    var password = $('#user_password').val();
    var remember_me = ($('#user_remember_me:checked').length !== 0) ? 1 : 0;
    $.ajax({
      method: 'post',
      url: '/users/sign_in',
      dataType: 'json',
      contentType: 'application/json',
      headers: {'X-CSRF-Token': $('input[name="authenticity_token"]').val()},
      data: JSON.stringify({'user': { 'email': email, 'password': password, 'remember_me': remember_me}})
    }).done(function(data) {
      console.log(data);
    }).fail(function(err) {
      console.log(err);
    });
  });

});