
class Application < ApplicationRecord
  validates_presence_of :name, :address, :rationale, :status, :city, :state, :zipcode
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  def search(name)

  end
end
