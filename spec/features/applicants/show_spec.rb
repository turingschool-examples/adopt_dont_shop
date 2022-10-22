require 'rails_helper'

# 1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
RSpec.describe 'applications show page' do 
    before (:each) do
        @applicant1 = Applicant.create!(name: "Judge Judy", street_address: "666 Elm St", city: "New Jersey", state: "NJ", zip: "8675309", status: 'In Progress')
        @applicant2 = Applicant.create!(name: "Pink Flyod", street_address: "5150 High St", city: "Crater Lake", state: "None", zip: "12345", good_fit: "I need a companion")
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet1 = @shelter_1.pets.create!(adoptable: true, age: 4, breed: "Rotweiller", name: "Raider")
        @pet2 = @shelter_1.pets.create!(adoptable: true, age: 99, breed: "Chihuahua", name: "Yoda")
        @pet3 = @shelter_1.pets.create!(adoptable: true, age: 5, breed: "Parakeet", name: "Raider")
    end
    it 'has the attributes of the applicant' do 
      
        visit "/applicants/#{@applicant1.id}"

        expect(page).to have_content(@applicant1.name)
        expect(page).to have_content(@applicant1.street_address)
        expect(page).to have_content(@applicant1.city)
        expect(page).to have_content(@applicant1.status)
        expect(page).to_not have_content(@applicant2.name)
    end

    it 'lists and links the pets for this application' do 
        @applicant1.pets << @pet1 << @pet2
        #pet1.applicants << applicant1 
        #pet2.applicants << applicant1
        #PetApplicants.create!(pet: pet2, shelter: shelter_1)
        visit "applicants/#{@applicant1.id}"
        
        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet2.name)

        
        click_link("Raider")
        expect(current_path).to eq("/pets/#{@pet1.id}")
    end

    # 4. Searching for Pets for an Application

    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search

    context 'Searching for Pets for an Application' do 
        it 'adds a click link for add pet to this application' do
            visit "/applicants/#{@applicant1.id}"

            expect(page).to have_content('Add a Pet to this Application')
            expect(page).to have_field('Search')
            expect(page).to have_selector(:button, 'Search Pets')
        end

        it 'adds search function to show page and redirects with matching searches' do
            visit "/applicants/#{@applicant1.id}"
            
            fill_in "Search", with: "Raider"
            click_button "Search Pets"

            expect(current_path).to eq("/applicants/#{@applicant1.id}")
            expect(page).to have_content('Raider')
            expect(page).to_not have_content('Yoda')
        end
    end

    # 5. Add a Pet to an Application

    # As a visitor
    # When I visit an application's show page
    # And I search for a Pet by name
    # And I see the names Pets that match my search
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    # When I click one of these buttons
    # Then I am taken back to the application show page
    # And I see the Pet I want to adopt listed on this application

    describe 'after search adds button adopt this pet' do
        it 'has a button to adopt this pet' do
            visit "/applicants/#{@applicant1.id}"

            fill_in "Search", with: "Raider"
            click_button "Search Pets"
            
            expect(page).to have_selector(:button, 'Adopt this Pet')
        end

        it 'links back to applicant show page and i see the pet' do 
            visit "/applicants/#{@applicant1.id}"

            fill_in "Search", with: "Raider"
            click_button "Search Pets"

            page.first(:button, 'Adopt this Pet').click

            expect(current_path).to eq("/applicants/#{@applicant1.id}")
            expect(page).to have_content('Raider')
        end
    end

    # 6. Submit an Application

    # As a visitor
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

    describe 'on application show page theres a section to submit my application' do
        it 'doesnt have submit application if no pets' do 
            visit "/applicants/#{@applicant1.id}"
            
            expect(page).to_not have_field(:good_fit)
            expect(page).to_not have_selector('Submit Application')
        end

        it 'has a section to fill out good fit and submit application' do 
            @applicant1.pets << @pet1 << @pet3

            visit "/applicants/#{@applicant1.id}"
            
            expect(page).to have_selector(:button, 'Submit Application')
            
            fill_in "Why are you a good fit?", with: "I'm a bad motha judger"
            click_button 'Submit Application'

            expect(current_path).to eq("/applicants/#{@applicant1.id}")
        end

        it 'redirects back to application show page and updates status, shows pet list, and removes add pets section' do
            @applicant1.pets << @pet1 << @pet3
            visit "/applicants/#{@applicant1.id}"
            require 'pry'; binding.pry
            fill_in "Why are you a good fit?", with: "I'm a bad motha judger"
            click_button 'Submit Application'

            save_and_open_page

            expect(page).to have_content('Pending')
            expect(page).to have_content('Raider')
            expect(page).to have_content('Raider')
            expect(page).to_not have_content('Add a Pet to this Application')
            expect(@applicant1.good_fit).to eq("I'm a bad motha judger")
        end
    end
end