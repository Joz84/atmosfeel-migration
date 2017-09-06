$ ->
  $('a.ajax-like-opus').on 'click', (event) ->
    event.preventDefault()
    queryPath = $(@).attr('href')
    $.ajax
      type: 'POST'
      url: queryPath