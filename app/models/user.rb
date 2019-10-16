class User < ApplicationRecord
	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  validates :first_name, :last_name, :email, :location, :state, presence: true
  validates :first_name, :last_name, :location, length: {minimum: 2}
  validates :state, length: {is: 2}
  validates :email, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  before_save :downcase_email
  before_save :precheck_pw_length

  has_many :events
  has_many :joins, dependent: :destroy
  has_many :events_joined, through: :joins, source: :event
  has_many :comments

  private
	  def downcase_email
	  	self.email.downcase!
	  end
	  def precheck_pw_length
	  	validates_length_of :password, :minimum => 8
	  end
end
