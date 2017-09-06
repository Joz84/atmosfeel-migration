$ ->
  if $('#congratulations').length
    modalShowed = 0

    $('#toggle-publish-link').on 'click', (event) ->
      event.preventDefault()
      queryPath = $(@).attr('href')
      $.ajax(
        type: 'GET'
        url: queryPath
      ).done ->
        if $('a#toggle-publish-link').hasClass('hidden') && modalShowed == 0
          $('#congratulations').modal('show')
          modalShowed = 1

    $('.prevent-popup').on 'click', ->
      modalShowed = 1      

    window.onbeforeunload = (event) ->
      if $('a#toggle-publish-link').hasClass('btn-success') && modalShowed == 0
        return "Vous devez publier ou supprimer votre oeuvre"