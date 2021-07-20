class PetApp < ApplicationRecord
  belongs_to :pet
  belongs_to :app

  validates :pet_id, presence: true
  validates :app_id, presence: true
end