class NewslettersController < ApplicationController

  def create
		@newsletter = Newsletter.new params[:newsletter]
		unless @newsletter.save
			respond_to {|format| format.html { render :json => error_messages(@newsletter), :status => :unprocessable_entity if request.xhr? }}
		else
			write_excel
			respond_to {|format| format.html { render :json => 'OK' if request.xhr? }}
		end
	end

	private

	  def write_excel
	  	ws = get_worksheet
	  	ws[get_row_number,1] = @newsletter.email
	  	ws[get_row_number,2] = Time.now.strftime('%d/%m/%Y')
	  	ws[get_row_number,3] = I18n.locale.to_s
	  	ws.save
	  end

	  def get_worksheet
	  	session = GoogleDrive.login('francksabattier@gmail.com','13JamirO10')
	  	if request.subdomain.match(/^(join|staging)$/)
				session.spreadsheet_by_key('0Anvdw7Lk3scOdG5mdEJwR0xNLVBTbzI5MnM0T2dKdkE').worksheets[0]
			elsif request.subdomain.match(/^(resume)$/)
				session.spreadsheet_by_key('0Anvdw7Lk3scOdGVHcXlKOVFQRmNxUHlxTUd2SXVrTGc').worksheets[0]
	  	elsif request.subdomain.match(/^(signup)$/)
	  		session.spreadsheet_by_key('0Anvdw7Lk3scOdF9qbEVxODZRNVE3N3YzLUlyTlpDelE').worksheets[0]
	  	end
	  end

	  def get_row_number
	  	Newsletter.where(from:request.subdomain).count + 1
	  end
end
