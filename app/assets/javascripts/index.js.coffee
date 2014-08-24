updateSettingsAsync = (key, value) ->
  data = {}
  data[key] = value
  $.post '/users/settings', data

$(document).ready ->
  $('.setting').change () ->
    selectId = $(this).attr('id')
    selectedValued = $('#' + selectId + ' option:selected').val()
    updateSettingsAsync selectId, selectedValued
