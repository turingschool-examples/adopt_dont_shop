class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, :street, :city, :state, :zip, :desc, presence: true

  def pet_names
    self.pets.pluck(:name)
  end
end
