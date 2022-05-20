class Application < ApplicationRecord
  validates_presence_of :name, :address, :status, :description
  has_many :application_pets
  has_many :pets, through: :application_pets
  def pets
    @pets = ApplicationPet.where("application_id = #{id}").map do |application_pet|
      Pet.find(application_pet.pet_id)
    end
  end
end
