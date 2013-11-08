class UserMailer < ActionMailer::Base
	default :from => "test@madisonandmainst.com"

	def registration_confirmation(user)
		@user = user
		mail(:to => user.email, :subject => "Registered")
	end

	def quote_request_confirmation(quote)
		@quote = quote
		mail(:to => quote.user.email, :subject => "Quote request submitted")
	end

	def password_reset(user)
		@user = user
		mail :to => user.email, :subject => "Password reset"
	end
end
