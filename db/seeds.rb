# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

@barc = Shelter.create!(name: 'BARC Shelter', city: 'Brookly, NY', foster_program: true, rank: 7)
@milton = Shelter.create!(name: 'Milton Animal League', city: 'Milton, MA', foster_program: false, rank: 5)
@muttville = Shelter.create!(name: 'Muttville Senior Dog Rescue', city: 'San Francisco, CA', foster_program: true, rank: 3)

@tabitha = @barc.pets.create!(name: 'Tabitha', breed: 'Burmese', age: 2, adoptable: true)
@maggie = @barc.pets.create!(name: 'Maggie', breed: 'Mastiff', age: 6, adoptable: true)
@pepper = @barc.pets.create!(name: 'Pepper', breed: 'Alaskan Malamute', age: 3, adoptable: false)

@thor = @milton.pets.create!(name: 'Thor', breed: 'Selkrik Rex', age: 4, adoptable: true)
@beau = @milton.pets.create!(name: 'Beau', breed: 'Maltese', age: 4, adoptable: false)
@jessie = @milton.pets.create!(name: 'Jessie', breed: 'Irish Setter', age: 2, adoptable: true)

@ace = @muttville.pets.create!(name: 'Ace', breed: 'Whippet', age: 10, adoptable: true)
@chester = @muttville.pets.create!(name: 'Chester', breed: 'Shiba Inu', age: 9, adoptable: true)
@nala = @muttville.pets.create!(name: 'Nala', breed: 'Newfoundland', age: 8, adoptable: true)

@janie = Application.create!(name: "Janie Wheeler",
                            street_address: "1877 Heron Way",
                            city: "Lyons",
                            state: "OR",
                            zip_code: "97358",
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi.",
                            status: "Pending"
                          )

@john = Application.create!(name: "John Cox",
                            street_address: "4470 Dola Mine Road",
                            city: "Raleigh",
                            state: "NC",
                            zip_code: "27608",
                            description: "Per possim laoreet ut, cu dicat populo altera usu, eius oportere euripidis pro ne. Nec tota prima verterem ad, tantas altera disputando qui ut.",
                            status: "Pending"
                          )

@rosalind = Application.create!(name: "Rosalind J Smith ",
                            street_address: "868 Jerry Toth Drive",
                            city: "Elmendorf",
                            state: "AK",
                            zip_code: "99506",
                            description: '',
                            status: "In Progress"
                          )

@jennifer = Application.create!(name: "Jennifer M Dietz",
                            street_address: "4079 Stonepot Road",
                            city: "Oldwick",
                            state: "NJ",
                            zip_code: "08858",
                            description: "Vis cu sonet constituto, ne nam veri sensibus persecuti. Tale albucius officiis sit no. Ea vix suas velit regione, ad accusata euripidis nam, est zril fierent inimicus id.",
                            status: "Pending"
                          )

@eddie = Application.create!(name: "Eddie K Sykes",
                            street_address: "3246 Hewes Avenue",
                            city: "Baltimore",
                            state: "MD",
                            zip_code: "21201",
                            description: '',
                            status: "In Progress"
                          )

@jennifer.pets << @maggie
@jennifer.pets << @tabitha
@john.pets << @nala
@john.pets << @ace
@janie.pets << @thor
