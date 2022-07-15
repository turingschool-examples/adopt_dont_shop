class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true, length: { is: 5 }
  validates :applicant_bio, presence: true
  validates :application_status, presence: true
  validates_inclusion_of :application_status, in: ['In Progress', 'Pending', 'Accepted', 'Rejected']
end
