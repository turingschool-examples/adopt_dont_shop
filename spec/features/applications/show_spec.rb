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
    end

    it 'can add a description and submit an app' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/applications/#{application.id}"

        fill_in("search", with:"Scooby")
        click_button("Search")
        click_button("Adopt this pet")
        fill_in("description", with:"I'm awesome")
        click_button("Submit Application")

        expect(page).to_not have_content("Submit Application")
        expect(page).to_not have_content("search")
        expect(page).to have_content("Application status: Pending")
        expect(page).to have_content("Scooby")
    end

    it 'will not show submit application button if no pets added' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

        visit "/applications/#{application.id}"
        
        expect(page).to_not have_content("Submit Application")
    end

    it 'will search all pets with a partial user input' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

        visit "/applications/#{application.id}"

        fill_in("search", with: "cill")
        click_button("Search")

        expect(page).to have_content("Lucille Bald")
    end

    it 'returns a case insenstive search' do
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
        pet2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

        visit "/applications/#{application.id}"

        fill_in("search", with: "UciLL")
        click_button("Search")

        expect(page).to have_content("Lucille Bald")
    end
end 
