class Application < ApplicationRecord
  before_save :set_default_val
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true, length: { is: 5 }
  # validates :applicant_bio
  # validates :application_status
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  def set_default_val
    self.application_status = 'In Progress'
  end

  def applicant_pets
    self.pets
  end
end
