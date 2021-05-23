class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  before_save :default_value

  def default_value
    self.application_status = 'In Progress'
  end

  def form_incomplete?
    self.name.blank? || self.street_address.blank? || self.city.blank? ||
    self.state.blank? || self.zip_code.blank? || self.description.blank?
  end
end
