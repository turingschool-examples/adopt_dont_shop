class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
  validates :name, :street_address, :city, :state, :zipcode, :description, presence: true

  def has_pets_added?
    self.pets.length != 0
  end

  def application_approved?
    ApplicationPet.where(application_id: self.id, status: "Approved").length == self.pets.length
  end
end
