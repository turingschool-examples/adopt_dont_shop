require 'rails_helper'

RSpec.describe "application show page" do
    #   As a visitor When I visit an applications show page Then I can see the following:
#     Name of the Applicant
#     Full Address of the Applicant including street address, city, state, and zip code
#     Description of why the applicant says they'd be a good home for this pet(s)
#     names of all pets that this application is for (all names of pets should be links to their show page)
#     The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    it 'displays the name, full address, description, names of all pets in the application as links, and the status of the application' do 
        new_applicant = Applicant.create!(name: "Test", address: "5555 Test Avenue", city: "Denver", state: "CO", zip: 55555, names_pets_wanted: "Fido", description: "they love pets!", application_status: "In Progress")
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        fido = shelter_1.pets.create(name: 'Fido', breed: 'Beagle', age: 5, adoptable: true)
        ApplicantPet.create!(pet: fido, applicant: new_applicant)
        visit "/applications/#{new_applicant.id}"
        
        # save_and_open_page
        expect(page).to have_content("name: Test")
        expect(page).to have_content("address: 5555 Test Avenue")
        expect(page).to have_content("city: Denver")
        expect(page).to have_content("state: CO")
        expect(page).to have_content("name of pets wanting to adopt: Fido")
        #Links to pets not currently working atm - Nick

        expect(page).to have_content("application_status:")

    end 

    it 'has pet name as a link' do 
        new_applicant = Applicant.create!(name: "Test", address: "5555 Test Avenue", city: "Denver", state: "CO", zip: 55555, names_pets_wanted: "Fido", description: "they love pets!", application_status: "In Progress")
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        fido = shelter_1.pets.create(name: 'Fido', breed: 'Beagle', age: 5, adoptable: true)
        applicant_pet = ApplicantPet.create!(pet: fido, applicant: new_applicant)

        visit "/applications/#{new_applicant.id}"

        expect(page).to have_link("#{fido.name}")
    end
        #  As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search

    it "it can add a pet to this application and search for pets" do
        new_applicant = Applicant.create!(name: "Test", address: "5555 Test Avenue", city: "Denver", state: "CO", zip: 55555, names_pets_wanted: "Fido", description: "they love pets!", application_status: "In Progress")
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        fido = shelter_1.pets.create(name: 'Fido', breed: 'Beagle', age: 5, adoptable: true)
        # applicant_pet = ApplicantPet.create!(pet: fido, applicant: new_applicant)

        visit "/applications/#{new_applicant.id}"
        expect(current_path).to eq("/applications/#{new_applicant.id}")
    
        fill_in 'search', with: 'Fido'
        click_on 'Search'
        expect(current_path).to eq("/applications/#{new_applicant.id}")
        expect(page).to have_link('Fido')
        # save_and_open_page
    end


    # Submit an Application

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

    it " can submit an application " do 
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        fido = shelter_1.pets.create(name: 'Fido', breed: 'Beagle', age: 5, adoptable: true)
        # applicant_pet = ApplicantPet.create!(pet: fido, applicant: new_applicant)

        visit "/applications/new"
        
        fill_in 'Name', with: 'Mary'
        fill_in 'Address', with: '5555 Test Avenue'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: 55555
        click_on 'Submit'
        test_applicant = Applicant.order("created_at").last
        expect(current_path).to eq("/applications/#{test_applicant.id}")

        fill_in 'search', with: 'Fido'
        click_on 'Search'
        click_on 'Adopt Fido'
        expect(current_path).to eq("/applications/#{test_applicant.id}")
        expect(page).to have_content("Fido")
        fill_in 'description', with: 'We love pets and take care of all animals'
        click_on 'Submit Application'
        # save_and_open_page
        expect(page).to have_content("application_status: Pending")
    end

        # No Pets on an Application
        # As a visitor
        # When I visit an application's show page
        # And I have not added any pets to the application
        # Then I do not see a section to submit my application

        it "doesn't show the option to submit application, if there are no pets selected" do
            shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
            fido = shelter_1.pets.create(name: 'Fido', breed: 'Beagle', age: 5, adoptable: true)
            # applicant_pet = ApplicantPet.create!(pet: fido, applicant: new_applicant)
    
            visit "/applications/new"
            
            fill_in 'Name', with: 'Mary'
            fill_in 'Address', with: '5555 Test Avenue'
            fill_in 'City', with: 'Denver'
            fill_in 'State', with: 'CO'
            fill_in 'Zip', with: 55555
            click_on 'Submit'
            test_applicant = Applicant.order("created_at").last
            expect(current_path).to eq("/applications/#{test_applicant.id}")
            # save_and_open_page
            expect(page).to_not have_content("Submit")
            expect(page).to_not have_content("Pending")
        end

        it 'can search for pets using partial matches' do 
            shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
            fido = shelter_1.pets.create!(name: 'Fido', breed: 'Beagle', age: 5, adoptable: true)
            sunny = shelter_1.pets.create!(name: 'Sunny', breed: 'Mastif', age: 7, adoptable: true)
            new_applicant = Applicant.create!(name: "Test", address: "5555 Test Avenue", city: "Denver", state: "CO", zip: 55555)

            visit "/applications/#{new_applicant.id}"

            fill_in('search', with: 'Su')
            click_on 'Search'
            save_and_open_page
            expect(page).to have_content('Sunny')
        end



# Case Insensitive Matches for Pet Names
# As a visitor
# When I visit an application show page
# And I search for Pets by name
# Then my search is case insensitive
# For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"

        it "can search for pets, where the term is case insensitive" do 
            shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
            fido = shelter_1.pets.create!(name: 'Fido', breed: 'Beagle', age: 5, adoptable: true)
            sunny = shelter_1.pets.create!(name: 'Sunny', breed: 'Mastif', age: 7, adoptable: true)
            new_applicant = Applicant.create!(name: "Test", address: "5555 Test Avenue", city: "Denver", state: "CO", zip: 55555)
    
            visit "/applications/#{new_applicant.id}"
    
            fill_in('search', with: 'sunny')
            click_on 'Search'
            # save_and_open_page
            expect(page).to have_content('Sunny')
        end
end