class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode
  validates_presence_of :description
  validates_presence_of :status

  def all_pets_approved?
    application_pets.all? {|application_pet| application_pet.approved? }
  end

  def all_pets_have_ruling?
    application_pets.none? {|application_pet| application_pet.pending? }
  end

  def any_pets_rejected?
    application_pets.any? {|application_pet| application_pet.rejected? }
  end
end
