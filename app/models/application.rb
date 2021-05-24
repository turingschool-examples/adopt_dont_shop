class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications, dependent: :destroy
  # after_initialize status: 'In Progress'
  # after_initialize description: ' '

  validates_presence_of :name, :state, :city, :zip_code, :address, :description

  # enum status: ["in_progress", "pending", "approved", "rejected"]
end
