$ ->
  $(document).on 'click', (e) ->
    $('.drop').removeClass('drop-open')
    
  $('.drop-handle').on 'click', (e) ->
    $('.drop').toggleClass('drop-open')

  $('.drop').on 'click', (e) ->
    e.stopPropagation()