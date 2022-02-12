require 'rails_helper'

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
        visit "/applications/#{@application_1.id}"
        expect(page).to have_content(@application_1.name)
        expect(page).to have_content(@application_1.street_address)
        expect(page).to have_content(@application_1.city)
        expect(page).to have_content(@application_1.state)
        expect(page).to have_content(@application_1.zipcode)
        expect(page).to have_content(@application_1.description)
    end

    it 'shows the user the names of all pets this application is for' do 
        visit "/applications/#{@application_1.id}"
        expect(page).to have_content(@mushu.name)
        expect(page).to have_content(@mantis.name)
        expect(page).to have_no_content(@bo.name)
    end 

    it 'has links to show page for all pets this application is for' do 
        visit "/applications/#{@application_1.id}"
        expect(page).to have_content("Mushu")
        click_link("Mushu")
        expect(current_path).to eq("/pets/#{@mushu.id}")
        expect(page).to have_content("Mushu")
    end 

    it 'shows the user the current status of their application' do 
        visit "/applications/#{@application_1.id}"
        expect(page).to have_content(@application_1.status)
    end

    it 'has a pet search field where the user can search for pets to add to application' do 
        visit "/applications/#{@application_1.id}"
        fill_in "search", with: "Moe"
        # Application must not be pending(fully submitted)
        expect(page).to have_content("Application Status: In Progress")
        click_button("Search")
        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_content("Moe")
    end

    it 'has a button that allows the user to add a pet from the search bar to their application' do 
        visit "/applications/#{@application_1.id}"
        expect(page).to have_no_content("Moe")
        fill_in "search", with: "Moe"
        click_button("Search")
        click_button("Adopt Moe!")
        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_content("Moe")
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

    it 'has a submission button once pets have been added to application' do 
        visit "/applications/#{@application_1.id}"
        expect(page).to have_no_content("Submit Application")
        fill_in "search", with: "Moe"
        click_button("Search")
        click_button("Adopt Moe!")
        expect(page).to have_content("Submit Application")
        fill_in("Please describe why you would make a good owner: "), with: "Gimme Moe"
        click_button("Submit Application")
        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_content("Pending")
        end
    end
end 