class App < ApplicationRecord
  has_many :app_pets
  has_many :pets, through: :app_pets
  validates :name, :address, :city, :zip_code, presence: true
  belongs_to :shelter
  attribute :status, :string, default: "In Progress"

end

public
def adopt(pet)
  self.pets << pet
end