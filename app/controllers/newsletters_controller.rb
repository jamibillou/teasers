class NewslettersController < ApplicationController
	require "rubygems"
	require "google_drive"

	def create
		@newsletter = Newsletter.new params[:newsletter]
		unless @newsletter.save
			respond_to {|format| format.html { render :json => error_messages(@newsletter), :status => :unprocessable_entity if request.xhr? }}			
		else
			write_excel()
			respond_to {|format| format.html { render :json => 'OK' if request.xhr? }}
		end
	end

	private

	  def write_excel
	  	ws = get_worksheet()
	  	
	  	ws[Newsletter.count+1,1] = @newsletter.email
	  	ws[Newsletter.count+1,2] = Time.now.strftime('%d/%m/%Y')
	  	ws.save()
	  end

	  def get_worksheet
	  	session = GoogleDrive.login('francksabattier@gmail.com','13JamirO10')
	  	if request.subdomain.match(/^join$/)
				session.spreadsheet_by_key('0Anvdw7Lk3scOdG5mdEJwR0xNLVBTbzI5MnM0T2dKdkE').worksheets[0]
	  	elsif request.subdomain.match(/^signup$/)
	  		session.spreadsheet_by_key('0Anvdw7Lk3scOdG5mdEJwR0xNLVBTbzI5MnM0T2dKdkE').worksheets[0]
	  	end
	  end
end
