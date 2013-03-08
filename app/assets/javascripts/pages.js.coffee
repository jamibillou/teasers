$ ->
  $('#loader').hide()

  # Placeholders
  # ------------

  $('#submit-placeholder').click -> $('#hidden-submit').click()


  # Mixpanel calls
  # --------------

  $('.cta-join').click       -> mixpanelCall('Clicked templates CTA')
  $('.cta-signup').click     -> mixpanelCall('Clicked feedback CTA')
  for i in [1..5]
    $('#cta_template_'+i).bind('click', {i: i}, (evt) ->
      mixpanelCall('Clicked Buy button',{'Template version' : evt.data.i}))

  # Newsletter form
  # ---------------

  $('#new_newsletter').bind('ajax:beforeSend', ->
    $('#loader').show())

  $('#new_newsletter').bind('ajax:success', (evt, xhr, status) ->
    $('#loader').hide()
    $('.control-group').removeClass('error') if $('.control-group').hasClass('error')
    $('.control-group').addClass('success')
    $('#feedback-message').html(I18n.t('pages.notif_modal.success_message')).show()
    mixpanelCall('Submitted templates email') if getSubdomain() is 'join'         
    mixpanelCall('Submitted feedback email')  if getSubdomain() is 'signup')

  $('#new_newsletter').bind('ajax:error',   (evt, xhr, status) ->
    $('#loader').hide()
    $('.control-group').removeClass('success') if $('.control-group').hasClass('success')
    $('.control-group').addClass('error')
    $('#feedback-message').html(xhr.responseText).show())

  # Slider
  # ------

  $('#arrow-left').mouseenter -> showSliderArrows()
  $('#arrow-right').mouseenter -> showSliderArrows()
  $('#arrow-left').mouseleave -> hideSliderArrows()
  $('#arrow-right').mouseleave -> hideSliderArrows()

  $('.arrow-left').click -> moveSlider('left')
  $('.arrow-right').click -> moveSlider('right')

  # Keypresses for the slider (for templates page only)
  # ---------------------------------------------------
  if $(location).attr('pathname') is '/templates'
    $('body').bind('keydown', (e) ->
      moveSlider('right') if e.keyCode is 39
      moveSlider('left')  if e.keyCode is 37)

# Mixpanel call
# -------------

mixpanelCall = (evt, properties) -> if properties is undefined then mixpanel.track(evt) else mixpanel.track(evt, properties)

# Slider
# ------

showSliderArrows = () ->
  $('#arrow-left').css('opacity', '1')
  $('#arrow-right').css('opacity', '1')

hideSliderArrows = () ->
  $('#arrow-left').css('opacity', '0')
  $('#arrow-right').css('opacity', '0')

moveSlider = (direction) ->
  length = if $(document).width() > 979 then 568 else 320
  margin = parseInt($('#slider').css('margin-left').replace('px', ''))
  if direction is 'left'
    $('#slider').css('margin-left', margin+length+'px') unless (margin >= 0 or margin%length != 0)
  else if direction is 'right'
    $('#slider').css('margin-left', margin-length+'px') unless (margin <= -1136 or margin%length != 0)

# Get subdomain
# -------------

getSubdomain = () -> location.hostname.split('.')[0]
