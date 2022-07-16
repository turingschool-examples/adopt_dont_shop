class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications  

  def self.search(pet_name)
    pets.where("name LIKE ?", "%#{pet_name}%")
  end
end