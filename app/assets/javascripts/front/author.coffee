$(document).ready ->
  if $('#authors').length
    ajaxQueryPath = $('.ajax-query-path').data('ajax-path')
    lastSorting = $('.opus-sorting a.active').data('order-attr')

    dataValue = (identifier, dataAttribute)->
      value = $(identifier).data(dataAttribute)
      value = 0 if value is undefined
      value

    toggleActive = (elements, element)->
      active = $(element).hasClass('active')
      $(elements).removeClass('active')
      $(element).addClass('active') unless active

    toggleSorting = (element)->
      orderVal = $(element).data('order-val')

      if lastSorting == null || lastSorting != $(element).data('order-attr')
        lastSorting = $(element).data('order-attr')
        toggleActive('.opus-sorting a', element)
        $('.opus-sorting a').children('i').removeClass('icon-caret-down').addClass('icon-caret-up')
        $('.opus-sorting a').children('i').data('order-val', 'asc')
      else if lastSorting == $(element).data('order-attr') && orderVal == 'asc'
        $(element).children('i').removeClass('icon-caret-up').addClass('icon-caret-down')
        $(element).data('order-val', 'desc')
      else if lastSorting == $(element).data('order-attr') && orderVal == 'desc'
        $(element).children('i').removeClass('icon-caret-down').addClass('icon-caret-up')
        $(element).data('order-val', 'asc')

    filterList = ->
      orderAttr = dataValue('.opus-sorting a.active', 'order-attr')
      orderVal = dataValue('.opus-sorting a.active', 'order-val')

      $.ajax(
        type: 'POST'
        url: ajaxQueryPath
        data:
          order:
            attr: orderAttr
            val: orderVal
      )

    $('.opus-sorting a').on 'click', (event) ->
      event.preventDefault()
      toggleSorting(@)
      filterList()

  if $('#sendmessage').length
    $('#sendmessage').on 'show.bs.modal', (e) ->
      clickedLink = $(e.relatedTarget)
      $('#sendmessage form').attr('action', clickedLink.data('action'))
      $('#sender-title').text(clickedLink.data('recipient-title'))
      $('#sender-avatar').attr('src', clickedLink.data('recipient-avatar'))