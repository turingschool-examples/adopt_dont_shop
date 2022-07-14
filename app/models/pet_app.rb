class PetApp < ApplicationRecord
  belongs_to :pet
  belongs_to :app
end