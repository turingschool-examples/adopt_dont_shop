class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip_code, :description, :status

  def default
    self.status = "In Progress"
    self.description = "_"
  end
end
