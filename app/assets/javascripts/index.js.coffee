updateSettingsAsync = (key, value) ->
  data = {}
  data[key] = value
  $.post '/users/settings', data

refreshStatistics = () ->
  $.ajax
    url: '/dashboard/statistics'
    success: (data) -> $('#statistics').html(data)

$(document).ready ->
  $('.setting').change () ->
    selectId = $(this).attr('id')
    selectedValued = $('#' + selectId + ' option:selected').val()
    updateSettingsAsync selectId, selectedValued

  setInterval(refreshStatistics, 5000)