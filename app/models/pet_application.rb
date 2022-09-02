class PetApplication < ApplicationRecord
  validates :pet_id, presence: true
  validates :application_id, presence: true
  belongs_to :application
  belongs_to :pet


end
