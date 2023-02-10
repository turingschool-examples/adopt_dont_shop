class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def in_progress?
    pets == []
  end
end