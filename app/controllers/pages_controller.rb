class PagesController < ApplicationController
	require "rubygems"
	require "google_drive"

	before_filter :write_excel, only: :join

	def join
		@title = t('pages.join.title')
	end

	def signup
		@title = t('pages.signup.title')
	end

	private

	  def write_excel
	  	session = GoogleDrive.login('francksabattier@gmail.com','13JamirO10')
	  	ws = session.spreadsheet_by_key('0Anvdw7Lk3scOdG5mdEJwR0xNLVBTbzI5MnM0T2dKdkE').worksheets[0]

	  	ws[2,1] = 'loubi@gmail.com'
	  	ws[2,2] = Time.now.strftime('%d/%m/%Y')
	  	ws.save()
	  end
end
