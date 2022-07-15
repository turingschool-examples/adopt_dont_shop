require 'rails_helper'

RSpec.describe 'application show page' do
    it 'displays the name of the applicant' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        
        visit "/applications/#{application.id}"

        expect(page).to have_content(application.name)
    end

    it 'displays the full address of the applicant' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        
        visit "/applications/#{application.id}"

        expect(page).to have_content(application.street)
        expect(page).to have_content(application.city)
        expect(page).to have_content(application.state)
        expect(page).to have_content(application.zipcode)
    end

    it 'displays the all pets the application is for' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet1 = application.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/applications/#{application.id}"

        expect(page).to have_content(pet1.name)

        click_on(pet1.name)

        expect(current_path).to eq("/pets/#{pet1.id}")
    end

    it 'displays the application status' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        
        visit "/applications/#{application.id}"

        expect(page).to have_content(application.status)
    end

    it 'displays the description' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        
        visit "/applications/#{application.id}"

        expect(page).to have_content(application.description)
    end

     it 'has a an area to search for pets to add to an application' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/applications/#{application.id}"
        fill_in("search", with:"Scooby")
        click_button("Search")

        expect(page).to have_content(pet1.name)
    end

    it 'can add a pet to an application after searching based on name' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/applications/#{application.id}"
        fill_in("search", with:"Scooby")
        click_button("Search")
        click_button("Adopt this pet")

        within("#pet-#{pet1.id}") do
            expect(page).to have_content(pet1.name)
        end  
        save_and_open_page
    end

    # it 'can add a description and submit an app' do
    #     application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
    #     shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    #     pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    #     visit "/applications/#{application.id}"
    #     fill_in("search", with:"Scooby")
    #     click_button("Search")
    #     click_button("Adopt this pet")

    #     within("#pet-#{pet1.id}") do
    #         expect(page).to have_content(pet1.name)
    #     end  

    #     fill_in("description", with:"I'm awesome")
    #     click_button("Submit")
    # end
end 