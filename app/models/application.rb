class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  before_save :default_value

  def default_value
    self.application_status = 'In Progress'
  end
end
