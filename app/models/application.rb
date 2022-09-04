class Application < ApplicationRecord
  validates :name, presence: false
  validates :street_address, presence: false
  validates :city, presence: false
  validates :state, presence: false
  validates :zipcode, presence: false, numericality: false
  validates :status, presence: false
  validates :description, presence: false
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  # def show_matching_pets(search)
  #   Pets.select{ |pet| pet.name.include?(search) }
  # end

  # def self.search_pets_by_name(search_param)
  #
  # end

end
