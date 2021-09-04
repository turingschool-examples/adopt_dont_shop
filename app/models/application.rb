class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end
end
