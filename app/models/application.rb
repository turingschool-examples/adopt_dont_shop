class Application < ApplicationRecord 
  has_many :pet_applications
  has_many :pets, through: :pet_applications, dependent: :destroy
  validates :name, :street_address, :city, :state, :zipcode, :description, presence: true
  def search_for_pet(pet_name)
    if pet_name 
      name_present = Pet.find_by('name ILIKE ?', pet_name)
      if name_present 
        name_present
      else 
        "Pet name not in system"
      end
    end
  end
end