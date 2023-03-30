class Veterinarian < ApplicationRecord
  validates :name, presence: true
  validates :review_rating, presence: true, numericality: true
  belongs_to :veterinary_office
  has_many :shelter_veterinarians
  has_many :shelters, through: :shelter_veterinarians

  def office_name
    veterinary_office.name
  end

  def self.on_call
    where(on_call: true)
  end
end
