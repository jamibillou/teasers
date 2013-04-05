class PagesController < ApplicationController

	before_filter :new_newsletter

  def join
		@title = t('pages.join.title')
    @price = ab_test('Price notification','2','5','10')
	end

	def signup
		@title = t('pages.signup.title')
	end

  def templates
    @title = t('pages.templates.title')
  end

  def resume
    @title = t('pages.resume.title')
    @price = ab_test('Price notification','true','false')
  end

  private
    def new_newsletter
      @newsletter = Newsletter.new
    end
end
