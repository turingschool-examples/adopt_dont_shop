class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.find_pet_by_name(name)
    pets.find.where(params[:name] == name)
  end
end
