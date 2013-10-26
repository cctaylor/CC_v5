# == Schema Information
#
# Table name: quotes
#
#  id         :integer          not null, primary key
#  item       :string(255)
#  paper      :string(255)
#  fold       :string(255)
#  color1     :string(255)
#  color2     :string(255)
#  quantity   :integer
#  message    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  quote_name :string(255)
#  status     :string(255)      default("NEW")
#

class Quote < ActiveRecord::Base
	attr_accessible :color1, :color2, :fold, :item, :message, :paper, :quantity, :quote_name
	belongs_to :user

	validates :item, presence: true
	validates :paper, presence: true
	validates :fold, presence: true
	validates :color1, presence: true
	validates :color2, presence: true
	validates :quantity, presence: true
	validates :user_id, presence: true
	validates :quote_name, presence: true, uniqueness: true, length: (6..32)
	validates :status, presence: true

	ITEM_TYPES = ["Flyer", "Brochure", "Postcard", "Business card", "Notecard"]
	COLOR_TYPES = ["Color", "Black and white"]
	COLOR_TYPES_BACK = ["None (1-sided)", "Color", "Black and white"]
	PAPER_TYPES = ["Standard copy paper (28#)", "Gloss text", "Matte cardstock", "Gloss cardstock"]
	FOLD_TYPES = ["None", "Half fold", "Tri-fold"]
	QUANTITY_TYPES = [50, 100, 250, 500, 1000, 2000]
	STATUS_CODES = ["NEW", "PENDING CLARIFICATION", "REVISED", "RESPONDED", "ACCEPTED", "DECLINED", "IN PRODUCTION", "PENDING PAYMENT", "COMPLETE"]

	default_scope order: 'quotes.created_at DESC'
end
