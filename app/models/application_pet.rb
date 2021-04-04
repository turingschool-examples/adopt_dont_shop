class ApplicationPet < ApplicationRecord
  validates_uniqueness_of :pet_id, scope: :application_id

  belongs_to :application
  belongs_to :pet
end
