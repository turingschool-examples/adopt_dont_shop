class Applicant < ApplicationRecord
  validates :name, presence: true
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :description, presence: true
  enum status: { "In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3 }

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  # def find_pet
  #   pets.where('name LIKE ?', '?%'.titleize)
  # end
end
