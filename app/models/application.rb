class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  after_initialize do |application|
    application.status = 'Pending' if !application.status
  end

end
