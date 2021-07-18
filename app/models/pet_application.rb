class PetApplication < ApplicationRecord
  # validates :
  belongs_to :pet
  belongs_to :application
end