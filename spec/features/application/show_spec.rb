require 'rails_helper'
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
RSpec.describe 'The application Show page' do 
    before :each do 
        @application_1 = Application.create!(name: "Sedan", street_address: "3425 Fansfield", city: "Denver", state: "CO", zipcode: "80219", description: "I love dogs")
        @application_2 = Application.create!(name: "Roman", street_address: "2354 Narwal", city: "Littleton", state: "CO", zipcode: "80219", description: "I'm lonely")
        dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
        @mushu = @application_1.pets.create!(adoptable: true, age: "5", breed: "Dog", name:"Mushu", shelter: dumb_friends_league )
        @mantis = @application_1.pets.create!(adoptable: true, age: "2", breed: "cat", name:"Mantis", shelter: dumb_friends_league )
        @bo = @application_2.pets.create!(adoptable: false, age: "5", breed: "Dog", name:"Bo", shelter: dumb_friends_league )
        @moe = Pet.create!(adoptable: true, age: "6", breed: "Dog", name:"Moe", shelter: dumb_friends_league )
    end 
    it 'shows the user applicant attributes' do 
        visit "/application/#{@application_1.id}"
        expect(page).to have_content(@application_1.name)
        expect(page).to have_content(@application_1.street_address)
        expect(page).to have_content(@application_1.city)
        expect(page).to have_content(@application_1.state)
        expect(page).to have_content(@application_1.zipcode)
        expect(page).to have_content(@application_1.description)
    end

    it 'shows the user the names of all pets this application is for' do 
        visit "/application/#{@application_1.id}"
        expect(page).to have_content(@mushu.name)
        expect(page).to have_content(@mantis.name)
        expect(page).to have_no_content(@bo.name)
    end 

    it 'shows the user the current status of their application' do 
        visit "/application/#{@application_1.id}"
        expect(page).to have_content(@application_1.status)
    end
    
# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click search,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search

    it 'has a pet search field where the user can search for pets to add to application' do 
        visit "/application/#{@application_1.id}"
        fill_in "search", with: "Moe"
        # Application must not be pending(fully submitted)

        expect(page).to have_content("Application Status: In Progress")
        click_button("Search")
        expect(current_path).to eq("/application/#{@application_1.id}")
        expect(page).to have_content("Moe")

    end
end 