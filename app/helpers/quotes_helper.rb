module QuotesHelper
	def is_lead?(user)
		user.lead
	end

	def is_lead?
		current_user.lead
	end

	def is_customer?
		!current_user.lead
	end

end
