updateSettingsAsync = (key, value) ->
  data = {}
  data[key] = value
  $.post '/users/settings', data

$(document).ready ->
  $('.login-form button').on 'click', () ->
    alert('clicked')
  $('#ical_start_offset').change () ->
    value = $('#ical_start_offset option:selected').val()
    updateSettingsAsync 'ical_start_offset', value
  $('#ical_end_offset').change () ->
    value = $('#ical_end_offset option:selected').val()
    updateSettingsAsync 'ical_end_offset', value
