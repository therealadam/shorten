$(document).ready(function() {
  $('input[type=text]').focus(function() {
    $(this).attr('value', '');
  });
});