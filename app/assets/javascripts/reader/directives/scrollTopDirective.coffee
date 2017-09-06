app.directive 'scrollTop', () ->
  {
    restrict: 'A'
    link: (scope, $elm) ->
      $elm.on 'click', () ->
        $("body").animate({scrollTop: 0}, "slow")
  }
