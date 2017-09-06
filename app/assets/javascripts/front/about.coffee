$(document).ready ->
  littleCloud = $('#litte-cloud')

  if $('#litte-cloud').length

    $('#toggle-little-cloud').on 'click', (e) ->
      e.preventDefault()
      littleCloud.fadeToggle('slow')