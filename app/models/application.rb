class Application < ApplicationRecord 
  has_many :pet_applications
  has_many :pets, through: :pet_applications, dependent: :destroy
  validates :name, :street_address, :city, :state, :zipcode, :description, presence: true

  def search_for_pet(pet_name)
    name_present = Pet.where("name ILIKE ?", "%#{pet_name}%")
    if name_present.count == 0
      "Pet name not in system"
    else
      name_present
    end
  end
end