class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  @pets = Pet.joins(:pet_application).where(application_id: params[:id])
end
