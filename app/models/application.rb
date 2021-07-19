class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true, numericality: true
  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]

end
