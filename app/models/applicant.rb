class Applicant < ApplicationRecord
  has_many :pets, through: :applicant_pets, cache_counter: true

  validates_presence_of :name, :address, :description, :status

end
