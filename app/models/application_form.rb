class ApplicationForm < ApplicationRecord
validates_presence_of :name, :street_address, :city, :state, :zip_code, :description, :status

has_many :pet_applications
has_many :pets, through: :pet_applications



end
