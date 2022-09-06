class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def list_pets
    self.pets.where("application_pets.application_id = ?", self.id)
  end
end
