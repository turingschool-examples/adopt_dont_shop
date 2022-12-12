class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, :street_address, :city, :state, :zip_code, presence: true
  validates :zip_code, length: { is: 5 }
  validates :zip_code, :numericality => { :greater_than_or_equal_to => 0}

  def approved?
    if application_pets.where(pet_status: 'Approved').count == application_pets.count
      update!(status: "Approved")
      pets.update_all(adoptable: false)
    elsif application_pets.where(pet_status: 'Rejected').count > 0
      update!(status: "Rejected")
    end
  end
end