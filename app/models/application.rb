class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip_code
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  has_many :shelters, through: :pets

  def find_pa_status(pet_id)
    PetApplication.where(pet_id: pet_id, application_id: self.id).first.status
  end

  def find_app_approved(pet_id)
    app = Application.joins(:pets).where(pets: {id: pet_id }).pluck(:status)
    app.include?("Approved")
    
  end

  def status_message(pet_id)
    pa = find_pa_status(pet_id)
    if pa == 'true'
      'Application Approved!'
    elsif pa == 'false'
      'Application Rejected'
    end
  end
end
