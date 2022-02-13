class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates_uniqueness_of :pet, scope: :application
end
