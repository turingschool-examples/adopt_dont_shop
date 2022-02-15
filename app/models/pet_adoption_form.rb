class PetAdoptionForm < ApplicationRecord

  # write tests for this 
  belongs_to :pet
  belongs_to :adoption_form
end
