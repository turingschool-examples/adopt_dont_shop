class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  enum status: ['In Progress', 'Pending', 'Accepted', 'Rejected']
end
