class Event < ApplicationRecord
  belongs_to :user
  validates :name, :date, :location, :state, presence: true
  validates :state, length: {is: 2}
  validate :cannot_be_before

  has_many :joins, dependent: :destroy
  has_many :users, through: :joins, source: :user
  has_many :comments

  private
  	def cannot_be_before
  		if date.present? and date<Date.today
  			errors.add(:date, "Date can't be in the past")
  		end
  	end
end
