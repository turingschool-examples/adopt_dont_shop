class Application < ApplicationRecord
  enum status: [:in_progress, :pending, :accepted, :rejected]
  validates_presence_of :name
  validates_presence_of :address
  # validates_presence_of :description
  # validates_presence_of :pet_names
  # validates_presence_of :status
end
