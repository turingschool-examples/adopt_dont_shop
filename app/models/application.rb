class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  after_initialize do |application|
    application.status = 'Pending' if !application.status
  end

  def find_pet_application(pet_id)
    PetApplication.all.where(application_id: id).find_by(pet_id: pet_id)
  end

  def approved(pet_id)
    find_pet_application(pet_id).approved
  end

  def search_pets(query)
    Pet.search(query).reject { |pet| pets.include?(pet) }
  end
end
