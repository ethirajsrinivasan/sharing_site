class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates_presence_of :username

  # Associations
  has_many :locations
  has_many :location_users
  has_many :shared_locations,through: :location_users, source: :location
  
end
