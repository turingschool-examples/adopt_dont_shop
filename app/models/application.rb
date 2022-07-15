class Application < ApplicationRecord
    has_many :pet_applications
    has_many :pets
end