require 'rails_helper'

RSpec.describe 'the Application index page' do
    it 'should display all of the applications' do
        # Shelters
        aurora_shelter = Shelter.create(   name: 'Aurora shelter', 
                                    city: 'Aurora, CO', 
                                    foster_program: false, 
                                    rank: 9)

        rgv_animal_shelter = Shelter.create(name: 'RGV animal shelter', 
                                            city: 'Harlingen, TX', 
                                            foster_program: false, 
                                            rank: 5)
        
        fancy_pets_of_colorado = Shelter.create(name: 'Fancy pets of Colorado', 
                                                city: 'Denver, CO', 
                                                foster_program: true, 
                                                rank: 10)

        # Pets
        lobster = aurora_shelter.pets.create(   adoptable: true, 
                                                age: 3, 
                                                breed: 'doberman', 
                                                name: 'Lobster', 
                                                shelter_id: aurora_shelter.id)

        clawdia = rgv_animal_shelter.pets.create!(   name: 'Clawdia', 
                                                breed: 'shorthair', 
                                                age: 3, 
                                                adoptable: true)

        lucille_bald = rgv_animal_shelter.pets.create!(  name: 'Lucille Bald', 
                                                    breed: 'sphynx', 
                                                    age: 8, 
                                                    adoptable: true)

        # Playlists
        lucas_application = Application.create!(   name: 'Lucas Colwell',
                                                            street_address: '123 Fake Street',
                                                            city: 'Salt Lake City',
                                                            state: 'Utah',
                                                            zipcode: 12345,
                                                            description: 'This is another test.',
                                                            status: 'Complete')

        blake_application = Application.create!(name: 'Blake Saylor',
                                                street_address: '638 East Franklin Place',
                                                city: 'Edmond',
                                                state: 'Colorado',
                                                zipcode: 80235,
                                                description: 'I just want a cat and I will be nice to it.',
                                                status: 'Pending')

        john_application = clawdia.applications.create!(name: 'John Roberts',
                                                        street_address: '4653 North Bend Street',
                                                        city: 'Longmont',
                                                        state: 'Oklahoma',
                                                        zipcode: 90210,
                                                        description: 'Ready to finally get a pet dog.',
                                                        status: 'In Progress')

        blue = lucas_application.pets.create!(  name: 'Blue', 
                                                breed: 'golden retriever', 
                                                age: 11, 
                                                adoptable: true,
                                                shelter: fancy_pets_of_colorado)

        ApplicationPet.create!(pet: blue, application: blake_application)
        ApplicationPet.create!(pet: lobster, application: blake_application)

        john_application.pets << lobster

        lucille_bald.applications << john_application

        visit '/applications'

        within("#application-#{lucas_application.id}") do
            expect(page).to have_content(lucas_application.name)
            expect(page).to have_content(blue.name)
        end

        within("#application-#{blake_application.id}") do
            expect(page).to have_content(blake_application.name)
            expect(page).to have_content(blue.name)
            expect(page).to have_content(lobster.name)
        end

        within("#application-#{john_application.id}") do
            expect(page).to have_content(john_application.name)
            expect(page).to have_content(lobster.name)
            expect(page).to have_content(lucille_bald.name)
            expect(page).to have_content(clawdia.name)
        end
    end
end