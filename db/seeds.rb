# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
class Seed
  def self.start
    seed = Seed.new
    seed.generate_shelters
    seed.generate_pets
    seed.generate_applications
    seed.generate_veterinarian_offices
    seed.generate_veterinarians
    # seed.generate_application_pets
  end

  def generate_shelters
    name = ["Terry's Terriers", 'Lost and Found', 'Too Many Tails', 'Dogs Unleashed', 'Woof and Purr']
    5.times do |i|
    shelter = Shelter.create!(
      foster_program: Faker::Boolean.boolean,
      name: name.pop,
      city: Faker::Address.city,
      rank: Faker::Number.between(from: 0, to: 5)
    )
    end
  end

  def generate_pets
    25.times do |i|
      shelter = Shelter.find(Random.new.rand(1..5))
      pet = shelter.pets.create!(
        adoptable: Faker::Boolean.boolean,
        age: Faker::Number.between(from: 0, to: 25),
        breed: Faker::Creature::Dog.breed,
        name: Faker::Creature::Dog.name
      )
    end
  end

  def generate_applications
    status = ["In Progress", "Pending", "Accepted", "Rejected"]
    15.times do |i|
      application = Application.create!(
        name: Faker::Name.unique.name,
        street_address: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip_code: Faker::Address.zip_code,
        description: Faker::Company.bs,
        status: status.sample
      )
      add_pets(application)
    end
  end

  def generate_veterinarian_offices
    5.times do |i|
      veterinary_office = VeterinaryOffice.create!(
        boarding_services: Faker::Boolean.boolean,
        max_patient_capacity: Faker::Number.between(from: 15, to: 30),
        name: Faker::FunnyName.name.concat("'s Vet Office")
      )
    end
  end

  def generate_veterinarians
    20.times do |i|
      veterinary_office = VeterinaryOffice.find(Random.new.rand(1..5))
      veterinarian = veterinary_office.veterinarians.create!(
        on_call: Faker::Boolean.boolean,
        review_rating: Faker::Number.between(from: 0, to: 5),
        name: Faker::Name.unique.name
      )
    end
  end

  def add_pets(application)
    10.times do |i|
      pet = Pet.find(Random.new.rand(1..25))
      application.pets << pet
    end
  end

  Seed.start
end
