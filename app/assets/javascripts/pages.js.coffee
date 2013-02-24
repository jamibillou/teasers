$ ->
  $('#loader').hide()

  # Placeholders
  # ------------

  $('#submit-placeholder').click -> $('#hidden-submit').click()


  # Mixpanel calls
  # --------------

  $('.cta-join').click -> mixpanelCall('Clicked CTA', {'Teaser version' : 'templates'})
  $('.cta-signup').click -> mixpanelCall('Clicked CTA', {'Teaser version' : 'feedback'})


  # Newsletter form
  # ---------------

  $('#new_newsletter').bind('ajax:beforeSend', ->
    $('#loader').show())

  $('#new_newsletter').bind('ajax:success', (evt, xhr, status) ->
    $('#loader').hide()
    $('.control-group').removeClass('error') if $('.control-group').hasClass('error')
    $('.control-group').addClass('success')
    $('#feedback-message').html(I18n.t('pages.notif_modal.success_message')).show()
    mixpanelCall('Submitted email'))

  $('#new_newsletter').bind('ajax:error',   (evt, xhr, status) ->
    $('#loader').hide()
    $('.control-group').removeClass('success') if $('.control-group').hasClass('success')
    $('.control-group').addClass('error')
    $('#feedback-message').html(xhr.responseText).show())


# Mixpanel call
# -------------

mixpanelCall = (evt, properties) -> if properties is undefined then mixpanel.track(evt) else mixpanel.track(evt, properties)