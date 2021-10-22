class Application < ApplicationRecord
  has_many :pets_applications
  has_many :pets, through: :pets_applications
end
