# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  Shelter.destroy_all
  ApplicationPet.destroy_all

  pound = Shelter.create!(foster_program: true,
                        name: "da pound",
                        city: "Denver",
                        rank: 1,
                        created_at: Time.now,
                        updated_at: Time.now
                        )
  dog = pound.pets.create!(name: "Bob",
                          adoptable: true,
                          age: 1,
                          breed: "smol",
                          created_at: Time.now,
                          updated_at: Time.now
                          )
  # applicant = dog.applications.create!(name: "Fred",
  #                                     street_address: "123 way",
  #                                     city: "Denver",
  #                                     state: "Colorado",
  #                                     zip_code: 80204,
  #                                     description: "I like dogs",
  #                                     created_at: Time.now,
  #                                     updated_at: Time.now
  #                                     )
  Application.create!(name: application ....)
  

  ApplicationPet.create!(application: applicant, pet: dog)
