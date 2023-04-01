class PetApplication < ApplicationRecord
  belongs_to :pets
  belongs_to :application
end