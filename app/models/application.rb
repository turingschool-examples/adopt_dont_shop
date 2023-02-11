class Application < ApplicationRecord
  validates_presence_of :applicant_name, :app_street, :app_city, :app_state, :app_zip_code, :description
  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]
end