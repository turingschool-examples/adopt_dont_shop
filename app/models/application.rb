class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  before_save :default_status

  def default_status
    self.status = 'In Progress'
  end
end
