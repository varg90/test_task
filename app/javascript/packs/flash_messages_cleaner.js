$(document).on('turbolinks:load', function() {
  return setTimeout(function() {
    return $('.alert:not(.persistent)').fadeOut();
  }, 5000);
});
