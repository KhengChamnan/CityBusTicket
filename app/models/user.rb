class User < ApplicationRecord
  has_secure_password
  has_many :bookings, dependent: :destroy
  has_many :sessions, dependent: :destroy
  validates :email_address, presence: true, uniqueness: true
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  # User account credit in dollars
  attribute :credit, :decimal, default: 0.0
end
