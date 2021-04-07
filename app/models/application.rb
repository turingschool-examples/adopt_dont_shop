class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications, dependent: :destroy
  validates_presence_of :name, :address, :city, :state, :zip_code
  after_initialize :default, unless: :persisted?

  def default
    self.description = "_"
    self.status = "In Progress"
  end
end
