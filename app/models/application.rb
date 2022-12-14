class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :status, presence: true, inclusion: [ "In Progress", "Pending", "Approved", "Denied" ]
  validates :description, length: { minimum: 2 }

  has_many :application_pets
  has_many :pets, through: :application_pets

  def address
    "#{street_address} #{city} #{state} #{zip_code}"
  end

  def pet_names
    self.pets.map do |pet| 
    pet.name
    end
  end

  def in_progress?
    self.status == "In Progress"  
  end

  def has_pets?
    self.pets.any?
  end
  
  def no_description?
    self.description.nil? || self.description == "Waiting for user description."
  end

end