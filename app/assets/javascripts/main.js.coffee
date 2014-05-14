console.log 'Hello from JavaScript!'

# FIXME: use a.js-pjax and make any links update to use it
$(document).pjax('a', '#js-pjax-container', { timeout: 1000, scrollTo: false })

$("#js-pjax-container").on "transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd", () ->
  console.log('transition end')
  #$("#js-pjax-container").removeClass("transition animated fadeInDown fadeOut")
  #$("#js-pjax-container").addClass("transition animated fadeInDown")

$(document)
  .on 'pjax:start', () ->
    console.log('start')
    $("#js-pjax-container").removeClass('animated fadeInDown fadeInUp').addClass("animated fadeOut")    
  .on 'pjax:end', () ->
    console.log('end')
    setTimeout ( ->
      console.log('timeout')
      $("#js-pjax-container").removeClass("animated fadeOut")
      $("#js-pjax-container").addClass("animated fadeInUp")
    ), 600
