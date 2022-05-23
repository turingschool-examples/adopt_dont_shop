class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  has_many :application_pets
  has_many :pets, through: :application_pets

  def status
    "In Progress"
  end

  def find_pet
    Pet.all.each do |pet|
      require "pry"; binding.pry
      if :pet_select == pet.name
        return pet.name
      else
        return "Sorry No Pets Match Your Search"
      end
    end
  end
end
