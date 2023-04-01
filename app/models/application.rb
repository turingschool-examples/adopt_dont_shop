class Application < ApplicationRecord
  validates :name, presence: true
  has_many :pets_applications
  has_many :pets, through: :pets_applications

  def self.search_pet(name)
    Application.where(name_of_pet: name)
  end
end