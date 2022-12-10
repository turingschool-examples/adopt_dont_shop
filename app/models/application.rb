class Application < ApplicationRecord
  # validates_presence_of :name, :message => "Please complete applicant name"
  # validates_presence_of :street_address, :message => "Please complete address: street address"
  # validates_presence_of :city, :message => "Please complete address: city"
  # validates_presence_of :state, :message => "Please complete address: state"
  # validates_presence_of :zip_code, :message => "Please complete address: zip code"
  # validates_presence_of :description, :message => "Please complete description."
  
  def address
    "#{street_address} #{city} #{state} #{zip_code}"
  end
end