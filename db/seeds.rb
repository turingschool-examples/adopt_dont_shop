# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Application.destroy_all
Shelter.destroy_all
Pet.destroy_all

3.times do
  Shelter.create do |shelter|
    shelter.name = Faker::Company.name
    shelter.city = Faker::Address.city
    shelter.foster_program = [true, false].sample
    shelter.rank = rand(1..10)
    7.times do
      shelter.pets.new do |pet|
        pet.name = Faker::Creature::Dog.name
        pet.breed = Faker:: Creature::Dog.breed
        pet.age = rand(1..18)
        pet.adoptable = [true, false].sample
      end
    end
  end
end

3.times do
  Application.create do |app|
    app.name = Faker::Name.name
    app.street_address = Faker::Address.street_address
    app.city = Faker::Address.city
    app.state = Faker::Address.state
    app.zip_code = Faker::Address.zip_code
    app.description = Faker::Fantasy::Tolkien.poem
  end
end
