class App < ApplicationRecord
  has_many :app_pets
  has_many :pets, through: :app_pets
  validates :name, :address, :city, :zip_code, presence: true
  belongs_to :shelter
  attribute :status, :string, default: "In Progress"

end

public
def adopt(pet)
  self.pets << pet if !self.pets.include?(pet)
end

def pet_status
  status_hash = Hash.new
  self.pets.each do |pet|
    status = AppPet.where({app_id: self.id, pet_id: pet.id}).pluck(:status)[0]
    status_hash[pet] = status
  end
  status_hash
end

def update_status(pet_status)
  if pet_status.none?("pending")
    if pet_status.all?("approved")
      self.update(status: "Approved")
      self.pets.each do |pet|
        pet.update(adoptable: false)
      end
    elsif pet_status.any?("rejected")
      self.update(status: "Rejected")
    end
  end
end
