class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def pet_application_by_pet(pet)
    pet_applications.where(pet_id: pet.id).first
  end
end
