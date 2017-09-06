$ ->
  # init
  $('.tabs-accordeon').find('.tabs li').addClass('selected');
  $('.tabs-accordeon').find('.panel-tab').eq(0).show();

  $('.tabs-accordeon').find('.drawer a').removeClass('selected');
  $('.tabs-accordeon').find('.drawer a').eq(0).addClass('selected');

  $('.tabs-accordeon .tabs a').on('click', (e) ->
    e.preventDefault()
    # get hash
    id = $(this).attr('href')

    # hide panels
    $wrapper = $(this).closest('.tabs-accordeon')
    $wrapper.find('.panel-tab').hide()
    $wrapper.find('.tabs a').removeClass("selected")
    $(this).addClass("selected")
    # show good panel
    $wrapper.find(id).show()
  )

  $('.tabs-accordeon').find('.drawer a').on('click', (e) ->
    e.preventDefault()
    id = $(this).attr('href')
    $wrapper = $(this).closest('.tabs-accordeon')
    $wrapper.find('.panel-tab').hide()

    $wrapper.find('.drawer a').removeClass("selected")
    $(this).addClass('selected')
    # show the good panel
    $wrapper.find(id).show()
  )