class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def change_status_to_pending
    self.status = "Pending"
  end
end