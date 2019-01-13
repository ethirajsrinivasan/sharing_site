class Location < ApplicationRecord

  # Associations
  belongs_to :user
  has_many :location_users
  has_many :shared_users, through: :location_users, source: :user

  # Validations
  validates :latitude , numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :public_site, inclusion: { in: [ true, false ] }

  scope :public_locations, -> { where(public_site: true) }
  scope :private_locations, -> { where(public_site: false) }
 
end
