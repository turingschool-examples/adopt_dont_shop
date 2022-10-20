class AdoptAppPet < ApplicationRecord
  belongs_to :pet
  belongs_to :adopt_app 
end