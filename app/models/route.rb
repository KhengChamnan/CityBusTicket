class Route < ApplicationRecord
  #associations
  belongs_to :origin_province, class_name: 'Province'
  belongs_to :destination_province, class_name: 'Province'
  
  #validations
  validates :origin_province_id, presence: true
  validates :destination_province_id, presence: true
  validates :distance_km, presence: true, numericality: { greater_than: 0 }
  validates :duration_min, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
