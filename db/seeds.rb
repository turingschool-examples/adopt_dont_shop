# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all
Applicant.destroy_all

dfl = Shelter.create!(name: 'Dumb Friends Leauge', rank: 12, city: 'Denver', foster_program: true)
jerry = Applicant.create!(name: 'Jerry', address_line_1: '123 First Street', city: 'Temecula', state: 'CA',
                          zipcode: '12345', description: 'I want more pets.')
kirby = jerry.pets.create!(name: 'Kirby', age: 4, breed: 'Maine Coon', adoptable: true, shelter_id: dfl.id)
pig = Pet.create!(name: 'Pig', age: 7, breed: 'Lab', adoptable: true, shelter_id: dfl.id)
