class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def has_pending_applications?
    applications.where(status: 'Pending').exists?
  end

  def self.adoptable
    where(adoptable: true)
  end

  def find_pending_applications
    applications.where(status: 'Pending')
  end
end
