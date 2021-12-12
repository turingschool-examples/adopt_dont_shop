class Application < ApplicationRecord
 has_many :adoptable_pets
 has_many :pets, through: :adoptable_pets

end
