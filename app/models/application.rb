class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street_address, :city, :state, :zip_code, presence: :true 
  validates_format_of :zip_code, with: /\A\d{5}-\d{4}|\A\d{5}\z/, message: "should be 12345 or 12345-1234", allow_blank: true

  enum app_status: ["In Progress", "Pending", "Accepted", "Rejected"]
end