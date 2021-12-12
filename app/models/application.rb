class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :description, presence: true
  validates :status, presence: true

  attribute :status, :string, default: "In Progress"
  # attribute :description, :string, default: "I am a lovely person. Ask my mom."
end
