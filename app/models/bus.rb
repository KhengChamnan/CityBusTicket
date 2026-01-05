class Bus < ApplicationRecord
  #validations
  validates :plate_number, presence: true, uniqueness: true
  validates :model, presence: true
  validates :capacity, presence: true
end
