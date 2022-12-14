class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
  attribute :status, :string, default: 'In Progress'
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true


  STATUS = ['In Progress', 'Pending', 'Approved', 'Rejected'].freeze
  #safety guard, nobody can access this/mess it up

  def full_address 
    "#{street_address}, #{city}, #{state} #{zip_code}"
  end

  def has_pets?
    !pets.empty?
  end

  def approved?
    if ApplicationPet.where(application_id: id).where(status: "Approved").any?
      #missing state change
      true
    else
      false
    end
  end

  def approved_pet
    # how does this account for multiple pets
    pet = ApplicationPet.where(application_id: id).where(status: "Approved").first.pet_id
    Pet.find(pet)
  end
end