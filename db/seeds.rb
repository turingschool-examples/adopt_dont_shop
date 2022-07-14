# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Application.destroy_all
ApplicationPet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

# shelter_1 = Shelter.create!(
#   foster_program: true,
#   name: "Denver Cat Shelter",
#   city: "Denver",
#   rank: 2
# )