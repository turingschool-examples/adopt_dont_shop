class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def self.only_pending
    where(status: "Pending")
  end
end