class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zip, presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications


  def dogs?
    pets.count > 0
  end

  def find_pet_app(pet_id)
    PetApplication.where('application_id = ? AND pet_id = ?', id, pet_id).first
  end

end
