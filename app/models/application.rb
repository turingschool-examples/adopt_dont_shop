
class Application < ApplicationRecord
  validates_presence_of :name, :address, :rationale, :status, :city, :state, :zipcode
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets


  def has_pets?
    !pets.empty?
  end
end
