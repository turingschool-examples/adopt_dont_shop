class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def incomplete_form?
    #  binding.pry
    self.name.blank? || self.street_address.blank? || self.city.blank? || self.state.blank? || self.zipcode.blank? #|| self.description.blank?
  end

  def list_incomplete_fields
   attribute_array = self.attributes.select do |attribute, v|
    v.blank?
   end
   attribute_array.keys
  end

  def has_pets_added?
    self.pets.length != 0
  end
end
