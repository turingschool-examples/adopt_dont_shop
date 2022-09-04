class Application < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  validates :street_address, presence: true, allow_blank: false
  validates :city, presence: true, allow_blank: false
  validates :state, presence: true, allow_blank: false
  validates :zipcode, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :status, presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
