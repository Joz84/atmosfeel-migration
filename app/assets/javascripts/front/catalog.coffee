$(document).ready ->
  isCatalog = ->
    $('#catalog').length

  isBiblioFeel = ->
    $('#bibliofeel').length

  isLikes = ->
    $('#likes-list').length

  if isBiblioFeel()
    url = document.location.toString();
    if url.match('tab')
      $('.nav-tabs a[href=#'+url.split('?tab=')[1]+']').tab('show')

    $('.bibliofeel-links a').on 'click', (e) ->
      $('.menu-mobile').addClass('hidden-xs').removeClass('open')
      $('.nav-tabs a[href=#'+$(e.target).attr('href').split('#')[1]+']').tab('show')

    $('.nav-tabs a').on 'shown.bs.tab', (e) ->
      $('.items').infinitePages('pause')
      $('.tab-pane.active').find('.items').infinitePages('resume')

  if isCatalog() or isBiblioFeel() or isLikes()
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

    displayFirstPage = ->
      $('.opus-pagination a').removeClass('active')
      $('#current-page').val(1)

    getAtmosphereId = ->
      dataValue('.atmospheres-list a.active', 'atmosphere-id')

    replaceHistoryState = (filter) ->
      params     = $.param(filter)
      actionName = window.location.pathname.substr(1)

      history.replaceState({}, '', "#{actionName}?#{params}")

    filterList = (replaceItems = true)->
      atmosphereId = getAtmosphereId()
      page = dataValue('.opus-pagination a.active', 'page')
      playTimeId = $('#filter_play_time_id').val()
      languageId = $('#filter_language_id').val()
      orderAttr = dataValue('.opus-sorting a.active', 'order-attr')
      orderVal = dataValue('.opus-sorting a.active', 'order-val')
      title = $('.used-search-filter').val()

      page = $('#current-page').val() if page is 0

      filterObject = {
        filter:
          page: page
          atmosphere_id: atmosphereId
          play_time_id: playTimeId
          language_id: languageId
          order_attr: orderAttr
          order_val: orderVal
          title: title
      }

      $.ajax(
        type: 'POST'
        url: ajaxQueryPath
        data:
          presentation:
            replace_items: replaceItems
          extra:
            current_tab: $('.tab-pane.active').attr('id')
            remove: dataValue('.tab-pane.active', 'remove')
            participated: dataValue('.tab-pane.active', 'participated')
          filter: filterObject.filter

      ).done ->
        replaceHistoryState(filterObject) if isCatalog() or isLikes()

        $('.opus-pagination a').on 'click', (event) ->
          event.preventDefault()
          $(@).addClass('active')
          filterList()

    if isCatalog() or isLikes()
      $('#items').infinitePages
        navSelector: ".opus-pagination a[rel=next]" # selector for the NEXT link (to page 2)
        alternateLoader: ->
          filterList(false)

    if isBiblioFeel()
      ['#participated_opuses', '#marketplace', '#experience'].forEach (id) ->
        $("#{id} .items").infinitePages
          navSelector: "#{id}_pagination a[rel=next]" # selector for the NEXT link (to page 2)
          alternateLoader: ->
            filterList(false)

        $("#{id}:not(.active) .items").infinitePages('pause')


    $('.filter-search-input').on 'keyup', ->
      $('.filter-search-input').removeClass('used-search-filter')
      $(@).addClass('used-search-filter')
      displayFirstPage()
      filterList()

    $('.atmospheres-list a').on 'click', (event) ->
      event.preventDefault()
      toggleActive('.atmospheres-list a', @)
      displayFirstPage()
      filterList()
      if $('.atmospheres-list a.active').length == 0
        $('.atmospheres-list a:first').addClass('active')

    $('.opus-sorting a').on 'click', (event) ->
      event.preventDefault()
      toggleSorting(@)
      displayFirstPage()
      filterList()

    $('#select-filters select').on 'change', ->
      displayFirstPage()
      filterList()

    $('.opus-pagination a').on 'click', (event) ->
      event.preventDefault()
      $(@).addClass('active')
      filterList()

    $('form.search-bar').on 'submit', (event) ->
      event.preventDefault()
