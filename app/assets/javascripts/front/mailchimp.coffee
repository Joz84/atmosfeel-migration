mailchimpPopup = ->
  # unsure to show the popup each time it's desired
  # see : http://is.gd/l3KdCk
  document.cookie = "MCEvilPopupClosed=; expires=Thu, 01 Jan 1970 00:00:00 UTC"
  require(["mojo/signup-forms/Loader"], (L) -> 
    L.start({"baseUrl":"mc.us10.list-manage.com","uuid":"7e182bc262f0bfaac3b4e39f5","lid":"9d320ee031"})
  )

$(document).ready ->
  $('.mailchimp-popup').on 'click', (e) ->
    e.preventDefault()
    mailchimpPopup()

  $('.mailchimp-popup').on 'touchstart', (e) ->
    e.preventDefault()
    mailchimpPopup()