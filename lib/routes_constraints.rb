class Signup < Struct.new(:value)
	def matches?(request)
		request.subdomain.present? && request.subdomain.match(/^signup$/)
	end
end