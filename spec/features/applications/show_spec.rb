require 'rails_helper' 

RSpec.describe 'guest applications show page' do 
    it 'shows an application and its attributes as well as pets on the application' do 
        shelter1 = Shelter.create!(foster_program: true,
                                   name: 'Rocky Mountain Dog Shelter',
                                   city: 'Denver',
                                   rank: 1)
        pet1 = shelter1.pets.create!(adoptable: true,
                                     age: 3,
                                     breed: "Labrador Retriever",
                                     name: 'Bailey')
        pet2 = shelter1.pets.create!(adoptable: true,
                                     age: 1,
                                     breed: "French Bulldog",
                                     name: 'Bella')
        pet3 = shelter1.pets.create!(adoptable: false,
                                     age: 4,
                                     breed: "German Shepard",
                                     name: 'Max')
        application1 = Application.create!(applicant_name: 'Jacob Yarborough', 
                                           street_address: '123 Main Street', 
                                           city: 'Denver', 
                                           state: 'CO',
                                           zipcode: '80223',
                                           application_status: 'Pending',
                                           why: 'I love dogs')
        application1.pets << pet1
        application1.pets << pet2

        visit "/applications/#{application1.id}"

        expect(current_path).to eq("/applications/#{application1.id}")
        expect(page).to have_content(application1.applicant_name)
        expect(page).to have_content(application1.street_address)
        expect(page).to have_content(application1.city)
        expect(page).to have_content(application1.state)
        expect(page).to have_content(application1.zipcode)
        expect(page).to have_content(pet1.name)
        expect(page).to have_content(pet2.name)
        expect(page).to have_content(application1.why)
        expect(page).to have_content(application1.application_status)

        click_link "#{pet1.name}"

        expect(current_path).to eq("/pets/#{pet1.id}")

        visit "/applications/#{application1.id}"
        click_link "#{pet2.name}"

        expect(current_path).to eq("/pets/#{pet2.id}")
    end 

    it 'has a search form to search for pets by name' do 
        shelter1 = Shelter.create!(foster_program: true,
                                   name: 'Rocky Mountain Dog Shelter',
                                   city: 'Denver',
                                   rank: 1)
        pet1 = shelter1.pets.create!(adoptable: true,
                                     age: 3,
                                     breed: "Labrador Retriever",
                                     name: 'Bailey')
        pet2 = shelter1.pets.create!(adoptable: true,
                                     age: 1,
                                     breed: "French Bulldog",
                                     name: 'Bella')
        pet3 = shelter1.pets.create!(adoptable: false,
                                     age: 4,
                                     breed: "German Shepard",
                                     name: 'Max')
        application1 = Application.create!(applicant_name: 'Jacob Yarborough', 
                                           street_address: '123 Main Street', 
                                           city: 'Denver', 
                                           state: 'CO',
                                           zipcode: '80223',
                                           application_status: 'Pending',
                                           why: 'I love dogs')

        visit "/applications/#{application1.id}"

        expect(current_path).to eq("/applications/#{application1.id}")

        fill_in "Search for Pet by Name", with: "b"
        click_button "Search"

        expect(current_path).to eq("/applications/#{application1.id}")
        expect(page).to have_content(pet1.name)
        expect(page).to have_content(pet1.age)
        expect(page).to have_content(pet1.breed)
        expect(page).to have_content(pet2.name)
        expect(page).to have_content(pet2.age)
        expect(page).to have_content(pet2.breed)
        expect(page).not_to have_content(pet3.name)
        expect(page).not_to have_content(pet3.age)
        expect(page).not_to have_content(pet3.breed)
    end 

    it 'allows a user to add pets to an application' do 
        shelter1 = Shelter.create!(foster_program: true,
                                   name: 'Rocky Mountain Dog Shelter',
                                   city: 'Denver',
                                   rank: 1)
        pet1 = shelter1.pets.create!(adoptable: true,
                                     age: 3,
                                     breed: "Labrador Retriever",
                                     name: 'Bailey')
        application1 = Application.create!(applicant_name: 'Jacob Yarborough', 
                                           street_address: '123 Main Street', 
                                           city: 'Denver', 
                                           state: 'CO',
                                           zipcode: '80223',
                                           application_status: 'Pending',
                                           why: 'I love dogs')

        visit "/applications/#{application1.id}"

        expect(current_path).to eq("/applications/#{application1.id}")
        
        fill_in "Search for Pet by Name", with: "b"
        click_button "Search"
        click_on "Adopt this Pet"

        expect(current_path).to eq("/applications/#{application1.id}")
        expect(page).to have_content(pet1.name)
    end 

    it 'can submit an application' do 
        shelter1 = Shelter.create!(foster_program: true,
                                   name: 'Rocky Mountain Dog Shelter',
                                   city: 'Denver',
                                   rank: 1)
        pet1 = shelter1.pets.create!(adoptable: true,
                                     age: 3,
                                     breed: "Labrador Retriever",
                                     name: 'Bailey')
        pet2 = shelter1.pets.create!(adoptable: true,
                                     age: 1,
                                     breed: "French Bulldog",
                                     name: 'Bella')
        pet3 = shelter1.pets.create!(adoptable: false,
                                     age: 4,
                                     breed: "German Shepard",
                                     name: 'Max')
        application1 = Application.create!(applicant_name: 'Jacob Yarborough', 
                                           street_address: '123 Main Street', 
                                           city: 'Denver', 
                                           state: 'CO',
                                           zipcode: '80223',
                                           application_status: 'Pending',
                                           why: 'I love dogs')

        # When I visit an application's show page
        # And I have added one or more pets to the application
        # Then I see a section to submit my application
        # And in that section I see an input to enter why I would make a good owner for these pet(s)
        # When I fill in that input
        # And I click a button to submit this application
        # Then I am taken back to the application's show page
        # And I see an indicator that the application is "Pending"
        # And I see all the pets that I want to adopt
        # And I do not see a section to add more pets to this application

        visit "/applications/#{application1.id}"
        expect(current_path).to eq("/applications/#{application1.id}")

        fill_in "Search for Pet by Name", with: "b"
        click_button "Search"
        click_on "Adopt this Pet"

        expect(current_path).to eq("/applications/#{application1.id}")
        expect(page).to have_content(pet1.name)

        expect(page).to have_content("Expression of Interest")
        click_on "Submit Application"

        expect(current_path).to eq("/applications/#{application1.id}")   
        expect(application1.application_status).to eq("Pending") 
        expect(page).to have_content(application1.applicant_name)
        expect(page).to have_content(application1.street_address)
        expect(page).to have_content(application1.city)
        expect(page).to have_content(application1.state)
        expect(page).to have_content(application1.zipcode)
        expect(page).to have_content(application1.why)
        expect(page).to have_content(application1.application_status)
        expect(page).to have_content(pet1.name)
        expect(page).not_to have_content("Adopt this Pet")
        expect(page).not_to have_content(pet2.name)
        expect(page).not_to have_content(pet3.name)     
    end 
end 