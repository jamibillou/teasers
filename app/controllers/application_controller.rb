class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery

	before_filter :set_locale

  private

    def set_locale
      locale = cookies[:default_locale].nil? && params[:locale].nil? ? get_locale_from_browser : params[:locale]
      cookies[:default_locale] = {value: locale, expires: 15.days.from_now.utc} unless locale.nil?
      I18n.locale = cookies[:default_locale]
    end

    def get_locale_from_browser
      request.env['HTTP_ACCEPT_LANGUAGE'].blank? ? 'en' : request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
end
