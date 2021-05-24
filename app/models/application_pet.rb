class ApplicationPet < ApplicationRecord
  belongs_to :pet_application
  belongs_to :pet
end
