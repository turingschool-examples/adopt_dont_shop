class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  attribute :adopted, :boolean, default: false
end