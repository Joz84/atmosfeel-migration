$(document).ready ->
  if $('#plan-select').length
    confirmPlan = $('#confirm-plan')
    discountPath = $('#discount-code')

    discountLinkValue = -> 
      discountPath.data('link')

    setDiscountLinkValue = (value) -> 
      discountPath.data('link', value)

    splittedDiscountPath = ->
      discountLinkValue().split('/')

    discountCodeIndex = ->
      2

    discountValue = ->
      splittedDiscountPath()[discountCodeIndex()]

    $("input[name='plan']").change ->
      if confirmPlan.attr('disabled')
        confirmPlan.removeAttr('disabled')  

      if discountValue() == 'none' || discountValue().length == 0        
        confirmPlan.attr('href', $(this).val())

    $("#discount-code-value").on 'keyup', ->
      if confirmPlan.attr('disabled')
        confirmPlan.removeAttr('disabled')  
      
      splittedPath = splittedDiscountPath()
      splittedPath[discountCodeIndex()] = $(this).val()
      setDiscountLinkValue(splittedPath.join('/'))
      if discountValue() != 'none' && discountValue().length > 0        
        confirmPlan.attr('href', discountLinkValue())
      else
        confirmPlan.attr('href', $("input[name='plan']:checked").val())