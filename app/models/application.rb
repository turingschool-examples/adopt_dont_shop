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
    pet_ids = pets.map {|pet| pet.id}
    int_approved_pet_ids = approved_pet_ids.map {|pet_id| pet_id.to_i}
    pet_ids.all? {|pet_id| int_approved_pet_ids.include?(pet_id)}
  end

  def all_pets_have_ruling?
    pet_ids = pets.map {|pet| pet.id}
    pet_ids.count == approved_pet_ids.count + rejected_pet_ids.count
  end

  def any_pets_rejected?
    pet_ids = pets.map {|pet| pet.id}
    int_rejected_pet_ids = rejected_pet_ids.map {|pet_id| pet_id.to_i}
    if all_pets_have_ruling?
      pet_ids.any? {|pet_id| int_rejected_pet_ids.include?(pet_id)}
    else
      false
    end
  end
end
