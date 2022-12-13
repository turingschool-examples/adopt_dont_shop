class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip_code
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  has_many :shelters, through: :pets
  def find_app_approved(pet_id)
    app = Application.joins(:pets).where(pets: {id: pet_id }).pluck(:status)
    app.include?("Approved")
  end
end
