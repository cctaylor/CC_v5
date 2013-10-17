# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name_first      :string(255)
#  name_last       :string(255)
#  email           :string(255)
#  phone           :string(255)
#  company         :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#  password_digest :string(255)
#  lead            :boolean          default(TRUE)
#  address1        :string(255)
#  address2        :string(255)
#  city            :string(255)
#  state           :string(255)
#  zip             :string(255)
#  zip4            :string(255)
#  password_salt   :string(255)
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
