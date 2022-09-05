class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  attribute :status, default: "Pending"

end
