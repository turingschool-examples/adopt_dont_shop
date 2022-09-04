class Application < ApplicationRecord
  include ::AASM
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates_presence_of :name, :street_address, :city, :state, :zip_code

  aasm column: :status do
    state :in_progress, initial: true, display: 'In Progress'
    state :pending, display: 'Pending'

    event :submit do
      transitions from: :in_progress, to: :pending
    end
  end

  # TODO: make this a class (self) method and remove Pet.all so it can be chained
  def search_pet(name)
    Pet.all.where("name ILIKE ?", "%#{name}%")
  end
end
