class PetAdoptionForm < ApplicationRecord

  belongs_to :pet
  belongs_to :adoption_form
end
