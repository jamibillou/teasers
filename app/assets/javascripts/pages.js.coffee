$ ->

  # Placeholders
  # ------------

  $('#submit-placeholder').click -> $('#hidden-submit').click()
  

	# Mixpanel calls for CTA buttons
	# ------------------------------

	$('.cta-join').each -> $(@).click -> mixpanelEvent('CV Templates')


# Calls the Mixpanel event
# ------------------------

mixpanelEvent = (teaser) -> mixpanel.track('Clicked CTA', {'teaser name' : teaser})
