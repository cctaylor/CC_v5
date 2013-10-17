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

class User < ActiveRecord::Base
  attr_accessible :name_first, :name_last, :email, :phone, :company, :password, :password_confirmation, :address1, :address2, :city, :state, :zip, :zip4
  attr_accessor :password, :password_confirmation
  has_many :quotes, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name_first, presence: true, length: { maximum: 25 }
  validates :name_last, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: (6..32), confirmation: true, if: (:setting_password? || :is_cust?)
  validates :phone, length: { minimum: 10 }, if: (:setting_password? || :is_cust?)
  validates :company, presence: true, if: (:setting_password? || :is_cust?)
  validates :address1, presence: true, if: (:setting_password? || :is_cust?)
  validates :city, presence: true, if: (:setting_password? || :is_cust?)
  validates :state, presence: true, length: { is: 2 }, if: (:setting_password? || :is_cust?)
  validates :zip, presence: true, length: { is: 5 }, if: (:setting_password? || :is_cust?)

  after_validation { self.errors.messages.delete(:password_digest) }

  STATES = ["TX","AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL",
          "GA","HI","IA","ID","IL","IN","KS","KY",
          "LA","MA","MD","ME","MI","MN","MO","MS",
          "MT","NC","ND","NE","NH","NJ","NM","NV",
          "NY","OH","OK","OR","PA","RI","SC","SD",
          "TN","UT","VA","VT","WA","WI","WV","WY"]


  def password=(password_str)
    @password = password_str
    self.password_salt    = BCrypt::Engine.generate_salt
    self.password_digest  = BCrypt::Engine.hash_secret(password_str, password_salt)
  end

  def authenticate(password)
    password.present? && password_digest.present? && password_digest == BCrypt::Engine.hash_secret(password, password_salt)
  end


  private
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end

    def setting_password?
      (self.password != '' && self.password != nil) || (self.password_confirmation != '' && self.password_confirmation != nil)
    end

    def is_lead?
      self.lead
    end

    def is_cust?
      !self.lead
    end
end
