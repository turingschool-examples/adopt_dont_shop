class PetForm < ApplicationRecord
  belongs_to :pet
  belongs_to :form
end