class PagesController < ApplicationController

	before_filter :new_newsletter

  def join
		@title = t('pages.join.title')
	end

	def signup
		@title = t('pages.signup.title')
	end

  def templates
    @title = t('pages.templates.title')
  end

  def resume
    @title = t('pages.resume.title')
  end

  private

    def new_newsletter
      @newsletter = Newsletter.new
    end
end
