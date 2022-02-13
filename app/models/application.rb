class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true, length: { is: 5 }
  # validates :description, presence: true
  validates :status, presence: true, inclusion: { in: ['In Progress', 'Pending', 'Accepted', 'Rejected'] }

  after_initialize :init

  def self.add_new_pet(pet, application_id)
    PetApplication.create!(pet_id: pet.id, application_id: application_id)
    pet
  end

  def init
    self.status ||= "In Progress"    
    self.description ||= ""
  end
end