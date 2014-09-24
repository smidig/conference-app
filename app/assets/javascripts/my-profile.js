$(function() {
  $('.dinner-question [data-remote]').on('ajax:success', function(event, data, status, xhr) {
    $(".dinner").html($(this).html());
    $(this).parent().html("Takk for din tilbakemelding!")
  });
});
