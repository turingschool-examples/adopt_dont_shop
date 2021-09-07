class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :status, presence: true

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  def pet_count
    pets.count
  end
end
