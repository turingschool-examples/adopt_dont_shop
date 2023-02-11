class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true
  
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def pets_list
    self.pets.pluck(:name).join(', ').chomp.chomp
  end
end
