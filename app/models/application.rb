class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :address, presence: true
  validates :status, presence: true
  validates :description, presence: true, allow_nil: true

  def has_pets?
    !pets.empty?
  end
end
