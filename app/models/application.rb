class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true
  validates :status, presence: true
  validates :description, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  # def show_matching_pets(search)
  #   Pets.select{ |pet| pet.name.include?(search) }
  # end

  # def self.search_pets_by_name(search_param)
  #
  # end

end
