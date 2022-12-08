class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  belongs_to :shelter

  def get_pets
    pet_apps = PetApplication.where(:application_id == self.id)
    pets = pet_apps.map do |pet_app|
      Pet.find(pet_app[:pet_id])
    end
  end
end