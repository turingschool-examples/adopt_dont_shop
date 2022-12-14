class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  enum status: {"in progress": 0, "pending": 1, "accepted": 2, "rejected": 3}
  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code
  validates_presence_of :description

  def add_pet(pet)
    self.pets << Pet.find(pet)
  end

  def self.pending_shelter_ids
    where(status: "pending").joins(:pets).distinct.pluck(:shelter_id)
  end

end
