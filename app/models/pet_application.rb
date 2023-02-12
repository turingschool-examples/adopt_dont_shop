class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates :application_id, presence: true
  validates :pet_id, presence: true
end