class Application < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  validates :address, presence: true
  validates :description, presence: true
  # validates :age, presence: true, numericality: true

  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: [:In_Progress, :Pending, :Accepted, :Rejected]

end 