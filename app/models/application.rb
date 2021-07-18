class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def associated_pets(application_id)
    PetApplication.where('application_id = ?', application_id).map do |join|
      Pet.find(join.pet_id)
    end
  end
end
