# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#


shelter_1 = Shelter.create!(foster_program: true,
                            name: "Visalia Animal Shelter",
                            city: "Visalia, CA",
                            rank: 10
                            )
application_1 = Application.create!(name: "Chris",
                                    street_address: "19072",
                                    city: "Exeter",
                                    state: "CA",
                                    zip: 93221,)
pet_1 = application_1.pets.create!(adoptable: true,
                            age: 5,
                            breed: "Llama",
                            name: "Cribonis",
                            shelter_id: shelter_1.id)
pet_2 = Pet.create!(adoptable: true,
                                      age: 7,
                                      breed: "Dog",
                                      name: "Luke",
                                      shelter_id: shelter_1.id)