$(function() {
  if ($('#resolutions-show').length === 0) {
    return;
  }

  $('#btn-approve-all').on('click', function() {
    $('input[value="approve"]').prop('checked', true);
  });

  $('#btn-reject-all').on('click', function() {
    $('input[value="reject"]').prop('checked', true);
  });

  $('input[value="approve"]').on('click', function() {
    $('#btn-approve-all').prop('checked', false);
    $('#btn-reject-all').prop('checked', false);
  });

  $('input[value="reject"]').on('click', function() {
    $('#btn-approve-all').prop('checked', false);
    $('#btn-reject-all').prop('checked', false);
  });
});
