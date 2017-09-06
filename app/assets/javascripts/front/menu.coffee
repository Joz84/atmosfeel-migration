$ ->
    
  $('.menu-mobile-handle').on('click', (e) ->
    $('.menu-mobile').addClass('open').removeClass('hidden-xs')
  )

  $('.menu-mobile-close').on('click', (e) ->
    $('.menu-mobile').addClass('hidden-xs').removeClass('open')
  )

  openMenu = $('body').data('open-menu')

  if openMenu == 1
    if $('.menu-mobile-handle').is(':visible')
      $('.menu-mobile-handle').trigger('click')
    else if $('.drop-handle').is(':visible')
      $('.drop-handle').trigger('click')
    

  $('.carousel').carousel()

  # search bar
  $('.search-bar-lg').hide()
  $('.search-bar-handle').on('click', () ->
    $('.search-bar-lg').slideToggle('fast')
  )
