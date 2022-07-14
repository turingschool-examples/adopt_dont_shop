class Application < ApplicationRecord
   validates :street_address
   validates :city
   validates :state
   validates :zipcode
   validates :description
   validates :status

   has_many :pets
   has_many :pets, through: :pet_applications
end
