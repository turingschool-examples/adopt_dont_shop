class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def pet_names
    self.pets.pluck(:name)
  end
end
