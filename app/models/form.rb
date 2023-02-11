class Form < ApplicationRecord
  has_many :pet_forms
  has_many :pets, through: :pet_forms

  enum status: ["In Progress", "Pending", "Accepted", "Rejected"] #<== this needs fixed.
  validates :name, :street_address, :city, :state, :zip_code, :description, presence: true
end