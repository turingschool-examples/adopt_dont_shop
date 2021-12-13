require 'rails_helper'
RSpec.describe 'the application show' do 
  before :each do 
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create!(adoptable: true, age: 5, breed: "Pug", name: "James")
    @application_1 = App.create!(name: "Rick James", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 0)
    visit "/apps/#{@application_1.id}"
  end 
  it "shows the appliation and all it's attributes" do 
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@pet_1.name)
  end 

  it 'can add pets to an application' do #combine this test and the next into one
    expect(page).to have_content("Add a Pet to this Application")

    fill_in("Add a Pet to this Application", with: "James")

    click_button("Search")
    expect(current_path).to eq("/apps/#{@application_1.id}")
    expect(page).to have_content("James")
  end 

  it 'can search for pets for an application' do 
    fill_in("Add a Pet to this Application", with: "James")
    click_button("Search")

    within '#james' do 
      click_button "Adopt this Pet"
      expect(current_path).to eq("/apps/#{@application_1.id}")
    end 

    expect(current_path).to eq("/apps/#{@application_1.id}")
    expect(page).to have_content("James")
  end 

  context 'when i visit the show page' do 
    describe 'it has a section to submit the application' do 
      it 'has a form for why i would be a good owner' do
        fill_in :description, with: "Because I'm a good human"
        
        within "#Submit" do 
          click_button "Submit"
        end 
        expect(current_path).to eq("/apps/#{@application_1.id}")

        expect(page).to have_content("Pending")
        expect(page).to have_content("James")
        expect(page).to have_content("Rick")
        expect(page).to_not have_content("Adopt this Pet")
      end 
    end 
  end 
end 
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
