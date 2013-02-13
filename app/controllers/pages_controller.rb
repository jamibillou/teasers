class PagesController < ApplicationController

	def join
		@title = t('pages.join.title')
	end

	def signup
		@title = t('pages.signup.title')
	end
end
