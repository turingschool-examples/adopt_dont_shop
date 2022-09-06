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

def update_status(pet_status, app)
  pet_status = @pet_status.values
  if pet_status.none?("pending")
    if pet_status.all?("approved")
      @app.update(status: "approved")
    elsif pet_status.any?("rejected")
      @app.update(status: "rejected")
    end
  end
end

def pet_status(app_id, pets)
  status_hash = Hash.new
  pets.each do |pet|
    status = AppPet.where({app_id: app_id, pet_id: pet.id}).pluck(:status)[0]
    status_hash[pet] = status
  end
  status_hash
end