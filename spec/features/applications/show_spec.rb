require 'rails_helper'

RSpec.describe 'application show page' do
    it 'displays the name of the applicant' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress" )
        
        visit "/applications/#{application.id}"

        expect(page).to have_content(application.name)
    end

    it 'displays the full address of the applicant' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "Colorado", zipcode: 80009, status:"In Progress" )
        
        visit "/applications/#{application.id}"

        expect(page).to have_content(application.street)
        expect(page).to have_content(application.city)
        expect(page).to have_content(application.state)
        expect(page).to have_content(application.zip_code)
    end

     it 'displays the all pets the application is for' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "Colorado", zipcode: 80009, status:"In Progress" )
        pet1 = application.pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/applications/#{application.id}"

        expect(page).to have_content(pet1.name)

        click_on(pet1.name)

        expect(current_path).to eq("/pets/#{pet1.id}")
    end

    it 'displays the application status' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "Colorado", zipcode: 80009, status:"In Progress" )
        
        visit "/applications/#{application.id}"

        expect(page).to have_content(application.status)
    end
end 