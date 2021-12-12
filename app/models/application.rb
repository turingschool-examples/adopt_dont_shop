class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  # validates :description, presence: true
  # validates :status, presence: true


  has_many :application_pets
  has_many :pets, through: :application_pets

  # add default for status
  attribute :status, :string, default: "In Progress"
  attribute :description, :string, default: "Animal lover"
end
