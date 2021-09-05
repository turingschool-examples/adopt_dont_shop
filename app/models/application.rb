class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  validates :name,    presence: true
  validates :address, presence: true
  validates :city,    presence: true
  validates :state,   presence: true
  validates :zip,     presence: true, numericality: true

  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end

  def status_pending
    self.status = "Pending"
  end
end
