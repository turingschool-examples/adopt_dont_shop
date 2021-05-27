class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.pending
    Application.select('applications.id, pets.shelter_id').joins(:pets).where(:status => "Pending")
  end

  def pet_count
    self.pets.count
  end

end
