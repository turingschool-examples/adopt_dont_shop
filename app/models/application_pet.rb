class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum status: [:pending, :approved, :rejected]
end
