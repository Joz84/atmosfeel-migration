$(document).ready ->
  formPanelSignIn                 = $('.form-panel-sign-in')
  formPanelSearch                 = $('.form-panel-search')
  formPanelSearchContainer        = $('#form-panel-search-container')
  leftOriginValue                 = formPanelSignIn.css('left') 

  clickOutside = (event) ->
    if !$(event.target).closest('.form-panel').length
      if formPanelSignIn.hasClass('opened')
        togglePanel(formPanelSignIn)
        togglePanel(formPanelSearch, false, ->
          toggleSearchPanelVisibility()
        )

  resetPanel = ->
    for child in $('.nav-sub').children()
      $(child).attr('style', '')
      $(child).removeClass('opened')
      $(child).removeClass('active')

    leftOriginValue = formPanelSignIn.css('left')
    formPanelSearchContainer.addClass('hidden')

  togglePanel = (panel, active = false, callback = false) ->
    leftValue = if panel.hasClass('opened') then leftOriginValue else 0

    if active && leftValue == 0
      panel.addClass('active') 
    else
      panel.removeClass('active') 

    panel.animate({
      left: leftValue
    }, ->
      panel.toggleClass('opened')

      callback() if callback
    )

  toggleSearchPanelVisibility = ->
    if formPanelSearch.hasClass('active')
      formPanelSearchContainer.removeClass('hidden')
    else
      formPanelSearchContainer.addClass('hidden')

  toggleSignInPanel = ->
    if !formPanelSearch.hasClass('active')
      togglePanel(formPanelSignIn, true)
      togglePanel(formPanelSearch)
    else
      $('.nav-sub').children().removeClass('active')
      formPanelSignIn.addClass('active')

    toggleSearchPanelVisibility()

  toggleSearchPanel = ->
    if !formPanelSearch.hasClass('opened')
      togglePanel(formPanelSignIn)
      formPanelSearch.addClass('active')
      toggleSearchPanelVisibility()
      togglePanel(formPanelSearch, true)
    else if !formPanelSignIn.hasClass('active')
      togglePanel(formPanelSignIn)
      togglePanel(formPanelSearch, true, ->
        toggleSearchPanelVisibility()
      )
    else
      $('.nav-sub').children().removeClass('active')
      formPanelSearch.addClass('active')
      toggleSearchPanelVisibility()

  # This is related to the soft keyboard on android
  # When it appear it trig the resize event...
  isAndroid = ->
    navigator.userAgent.toLowerCase().indexOf("android") > -1

  if (!isAndroid())
    $(window).on 'resize', ->
      resetPanel()
      $(document).off 'click', clickOutside
      if $(window).width() > 767
        $(document).on 'click', clickOutside

  $(window).on 'orientationchange', ->
    resetPanel()
    $(document).off 'click', clickOutside
    if $(window).width() > 767
      $(document).on 'click', clickOutside

  # Btn for SM, MD, LG breakpoints
  $('.form-panel-sign-in-btn-open').on 'click', (e) ->
    e.preventDefault()
    toggleSignInPanel()

  $('.form-panel-search-btn-open').on 'click', (e) ->
    e.preventDefault()
    toggleSearchPanel()

  # Btn for XS breakpoint
  $('#btn-xs-sign-in').on 'click', (e) ->
    e.preventDefault()
    $('.nav-sub').children().toggleClass('opened')
    formPanelSignIn.toggleClass('active')
    formPanelSignIn.fadeIn()

  $('#btn-xs-search').on 'click', (e) ->
    e.preventDefault()
    $('.nav-sub').children().toggleClass('opened')
    formPanelSearch.toggleClass('active')
    formPanelSearchContainer.removeClass('hidden')
    formPanelSearch.fadeToggle()

  # Btn close visible for all breakpoint 
  # Conditionnal behaviour
  $('.form-panel-btn-close').on 'click', (e) ->
    e.preventDefault()

    # For XS breakpoint
    if $('#btn-xs-search').is(':visible')
      formPanelSignIn.fadeOut()
      formPanelSearch.fadeOut()

      $('.nav-sub').children().removeClass('opened')
      $('.nav-sub').children().removeClass('active')
    # Others breakpoints
    else
      togglePanel(formPanelSignIn)
      togglePanel(formPanelSearch, false, ->
        toggleSearchPanelVisibility()
      )

  # Click outside menu
  if $(window).width() > 767
    $(document).on 'click', clickOutside