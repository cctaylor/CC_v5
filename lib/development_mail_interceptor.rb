class DevelopmentMailInterceptor
	def self.delivering_email(message)
		message.subject = "[#{message.to}] #{message.subject}"
		message.to = "cctaylor@gmail.com"
	end
end