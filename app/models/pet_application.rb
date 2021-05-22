class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  validates_presence_of :pet_id, :application_id
end