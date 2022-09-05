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

def pet_status(app_id, pets)
  status_hash = Hash.new
  pets.each do |pet|
    status = AppPet.where({app_id: app_id, pet_id: pet.id}).pluck(:status)[0]
    status_hash[pet] = status
  end
  status_hash
end