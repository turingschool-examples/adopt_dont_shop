class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def associated_pets(application_id)
    PetApplication.where('application_id = ?', application_id).map do |join|
      Pet.find(join.pet_id)
    end
  end
end
