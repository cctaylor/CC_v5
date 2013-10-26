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

require 'spec_helper'

describe Quote do
  pending "add some examples to (or delete) #{__FILE__}"
end
