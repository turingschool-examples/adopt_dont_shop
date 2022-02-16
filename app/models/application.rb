class Application < ApplicationRecord
  has_many :pet_applications, dependent: :delete_all
  has_many :pets, through: :pet_applications
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode, numericality: true, length: { is: 5 }

  enum status: {
    "In Progress" => 0,
    "Pending" => 1,
    "Accepted" => 2,
    "Rejected" => 3
  }

  def add_pet?(pet)
    PetApplication.new(pet_id: pet.id, application_id: self.id).save
  end

  def pending_app?
    status == "Pending"
  end
end
