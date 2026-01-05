class Bus < ApplicationRecord
  #validations
  validates :number_plate, presence: true, uniqueness: true
  validates :model, presence: true
  validates :capacity, presence: true
end
