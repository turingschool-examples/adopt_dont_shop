class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip_code
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  has_many :shelters, through: :pets

  def find_pa_status(pet_id)
    PetApplication.where(pet_id: pet_id, application_id: self.id).first.status
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
