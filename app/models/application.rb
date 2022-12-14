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
 
  def full_address 
    "#{street_address}, #{city}, #{state} #{zip_code}"
  end

  def has_pets?
    !pets.empty?
  end
end