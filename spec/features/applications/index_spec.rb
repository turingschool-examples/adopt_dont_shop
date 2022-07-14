require 'rails_helper'

RSpec.describe 'the Application index page' do
    it 'should display all of the applications' do
        aurora_shelter = Shelter.create(   name: 'Aurora shelter', 
                                    city: 'Aurora, CO', 
                                    foster_program: false, 
                                    rank: 9)

        lobster = aurora_shelter.pets.create( adoptable: true, 
                            age: 3, 
                            breed: 'doberman', 
                            name: 'Lobster', 
                            shelter_id: aurora_shelter.id)

        lucas_application = lobster.applications.create!(name: 'Lucas Colwell',
                                            street_address: '123 Fake Street',
                                            city: 'Salt Lake City',
                                            state: 'Utah',
                                            zipcode: 12345,
                                            description: 'This is another test.',
                                            status: 'Complete')

        visit '/applications'

        within("#application-#{lucas_application.id}") do
            # Have the name of the person on the application
            expect(page).to have_content(lucas_application.name)
            # Have the name of the pets they have applied for
            expect(page).to have_content(lobster.name)
        end
    end
end