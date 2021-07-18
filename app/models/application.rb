class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def associated_pets(application_id)
    PetApplication.where('application_id = ?', application_id).map do |join|
      join.pet_id
    end.map do |pet_id|
      Pet.find(pet_id).name
    end
  end
end
