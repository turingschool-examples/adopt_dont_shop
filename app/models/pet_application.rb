class PetApplication < ApplicationRecord
  validates :approved, presence: true
  belongs_to :pet
  belongs_to :application
end
