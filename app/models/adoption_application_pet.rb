class AdoptionApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :adoption_application
end
