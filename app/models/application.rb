class Application < ApplicationRecord
  validates :applicant_name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality:true
  validates :reason, presence: true
  validates :status, presence: true

  has_many :pets_applications
  has_many :pets, through: :pets_applications
end
