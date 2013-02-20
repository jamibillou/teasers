$ ->
  $('#loader').hide()

  # Placeholders
  # ------------

  $('#submit-placeholder').click -> $('#hidden-submit').click()
  

  # Mixpanel calls for CTA buttons
  # ------------------------------

  $('.cta-join').each   -> $(@).click -> mixpanelEvent('CV Templates')
  $('.cta-signup').each -> $(@).click -> mixpanelEvent('CV Feedback')

  # Newsletter form
  # ---------------

  $('#new_newsletter').bind('ajax:beforeSend', -> $('#loader').show())
  $('#new_newsletter').bind('ajax:success', (evt, xhr, status) -> 
    $('#loader').hide()
    $('#feedback-message').html('OK'))
  $('#new_newsletter').bind('ajax:error',   (evt, xhr, status) -> 
    $('#loader').hide()
    $('#feedback-message').html('Error'))

# Calls the Mixpanel event
# ------------------------

mixpanelEvent = (teaser) -> mixpanel.track('Clicked CTA', {'teaser name' : teaser})