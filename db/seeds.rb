# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

# Pet.destroy_all
# Shelter.destroy_all
# Application.destroy_all

2.times do
  FactoryBot.create(:shelter)
end

5.times do
  FactoryBot.create(:pet)
end

3.times do
  FactoryBot.create(:application)
end

pet1 = FactoryBot.create(:pet, shelter_id: shelter1.id)
pet2 = FactoryBot.create(:pet, shelter_id: shelter1.id)
pet3 = FactoryBot.create(:pet, shelter_id: shelter2.id)
pet4 = FactoryBot.create(:pet, shelter_id: shelter2.id)

application1 = FactoryBot.create(:application)
application2 = FactoryBot.create(:application)
application3 = FactoryBot.create(:application)

pet_application1 = PetApplication.create(pet_id: pet1.id, application_id: application1.id)
pet_application2 = PetApplication.create(pet_id: pet2.id, application_id: application1.id)
pet_application3 = PetApplication.create(pet_id: pet3.id, application_id: application2.id)
pet_application4 = PetApplication.create(pet_id: pet1.id, application_id: application3.id)
