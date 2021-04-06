class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip_code

  def description
    self.description = "_"
  end

  def status
    self.status = "In Progress"
  end
end
