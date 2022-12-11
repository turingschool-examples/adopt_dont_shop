class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, :street_address, :city, :state, :zip_code, presence: true
  validates :zip_code, length: { is: 5 }
  validates :zip_code, :numericality => { :greater_than_or_equal_to => 0}

  def application_pets
    pets.map do |pet|
      ApplicationPet.find_application_pet(id, pet.id)
    end
  end

  def approved?
    if application_pets.all? { |application_pet| application_pet.pet_status == 'Approved' }
      update(status: "Approved")
      save
      pets.each { |pet| pet.update(adoptable: false)
        pet.save }
    elsif application_pets.any? { |application_pet| application_pet.pet_status == 'Rejected' }
      update(status: "Rejected")
      save
    end
  end
end