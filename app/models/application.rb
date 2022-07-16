class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications  

  def self.search(search)
    pets.where("name LIKE ?", search)
  end
end