class PetApplication < ApplicationRecord
  belongs_to :owner_application
  belongs_to :pet
end
