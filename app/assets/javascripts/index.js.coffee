updateSettingsAsync = (key, value) ->
  data = {}
  data[key] = value
  $.post '/users/settings', data

$(document).ready ->
  $('.setting').change () ->
    selectId = $(this).attr('id')
    selectedValued = $('#' + selectId + ' option:selected').val()
    updateSettingsAsync selectId, selectedValued

  $('#login').on 'click', () ->
    $.ajax
      type: 'POST'
      url: '/users/login',
      data: {id: $('input[type="text"]').val()},
      async: false
      complete: () -> location.reload()
