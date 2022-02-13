class Application < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  attribute :description, :string, default: "TBFI later"
  attribute :status, :string, default: "In progress"

  has_many :pet_applications
  has_many :pets, through: :pet_applications

 def add_pet(pet)
   self.pets.push(pet)
 end
 def pets_present
   self.pets.count
 end
end
