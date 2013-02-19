class PagesController < ApplicationController

	def join
		@title = t('pages.join.title')
		@newsletter = Newsletter.new
	end

	def signup
		@title = t('pages.signup.title')
	end

end
