class AdoptionForm < ApplicationRecord

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code
  validates_presence_of :description

  # write tests for this later !!
  has_many :pet_adoption_forms
  has_many :pets, through: :pet_adoption_forms

  enum status: {"In Progress" => 0 , "Pending" => 1, "Accepted" => 2, "Rejected" => 3}
end
