class Application < ApplicationRecord   
  has_many :pet_applications
  has_many :pets, through: :pet_applications


#   def pets_wanted
#     # binding.pry
#     # desired_pets = Application.joins(:pets).where("application_id = #{id}")
#     # desired_pets.first.pets
#     pets
#   end
end