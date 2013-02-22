$ ->
  $('#loader').hide()

  # Placeholders
  # ------------

  $('#submit-placeholder').click -> $('#hidden-submit').click()


  # Mixpanel calls for CTA buttons
  # ------------------------------

  $('.cta-join').click -> mixpanelEvent('templates')
  $('.cta-signup').click -> mixpanelEvent('feedback')

  # Newsletter form
  # ---------------

  $('#new_newsletter').bind('ajax:beforeSend', ->
    $('#loader').show())

  $('#new_newsletter').bind('ajax:success', (evt, xhr, status) ->
    $('#loader').hide()
    $('.control-group').removeClass('error') if $('.control-group').hasClass('error')
    $('.control-group').addClass('success')
    $('#feedback-message').html(I18n.t('pages.notif_modal.success_message')).show())

  $('#new_newsletter').bind('ajax:error',   (evt, xhr, status) ->
    $('#loader').hide()
    $('.control-group').removeClass('success') if $('.control-group').hasClass('success')
    $('.control-group').addClass('error')
    $('#feedback-message').html(xhr.responseText).show())

# Calls the Mixpanel event
# ------------------------

mixpanelEvent = (teaser) -> mixpanel.track('Clicked CTA', {'Teaser version' : teaser})