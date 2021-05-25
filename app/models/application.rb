class Application < ApplicationRecord

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  # validates :name, exclusion:{in: ""}
  # validates :street_address, exclusion:{in: ""}
  # validates :city, exclusion:{in: ""}
  # validates :state, exclusion:{in: ""}
  # validates :zip_code, exclusion:{in: ""}
  # validates :description, exclusion:{in: ""}
end
