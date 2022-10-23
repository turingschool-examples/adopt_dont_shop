class Application < ApplicationRecord 
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :applicant, presence: true, on: :create, allow_blank: false
  validates :street, presence: true, on: :create, allow_blank: false
  validates :city, presence: true, on: :create, allow_blank: false
  validates :state, presence: true, on: :create, allow_blank: false
  validates :zipcode, presence: true, on: :create, allow_blank: false
  validates :reason, presence: true, on: :create, allow_blank: false
end
