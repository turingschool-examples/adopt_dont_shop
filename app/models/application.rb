class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :description, presence: true


  def change_status_to_pending
    self.status = "Pending"
  end


  def self.only_pending
    where(status: "Pending")
  end

end