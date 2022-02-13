class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  attribute :description, :string, default: ''

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :status, presence: true
  attribute :status, :string, default: "In Progress"
end
