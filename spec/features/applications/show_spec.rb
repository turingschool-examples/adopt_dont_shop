# [ ] done
#
# Application Show Page
#
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
require 'rails_helper'

RSpec.describe 'Application Show Page' do

  before(:each) do
    @app = Application.create!(name: 'Billy', city: 'Denver', street_address: '123 lion st', state: 'CO', zip: 12345, status: "In Progress", description: 'test')
    @shelter = Shelter.create!(foster_program: true,
     name: 'Bundle park',
     city: 'Denver',
     rank: 3
   )
    @dog1 = @shelter.pets.create!(adoptable: true,
       age: 2,
       breed: 'yes',
       name: 'Bob'
     )
   @dog2 = @shelter.pets.create!(adoptable: true,
      age: 2,
      breed: 'yes',
      name: 'Billy'
    )
  end

  it 'can display application info' do
    PetApplication.create!(pet: @dog1, application: @app)
    PetApplication.create!(pet: @dog2, application: @app)

    visit "/applications/#{@app.id}"

    within('#App-Info') do
      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.street_address)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zip)
      expect(page).to have_content(@dog1.name)
      expect(page).to have_content(@dog2.name)
      expect(page).to have_content(@app.description)
      expect(page).to have_content(@app.status)
    end
  end

  it 'can search for pets' do
    visit "/applications/#{@app.id}"

    expect(page).to have_content('Add a Pet to this Application')
    expect(page).to_not have_content(@dog1.name)
    expect(page).to have_content('In Progress') # And that application has not been submitted. Search bar contingent on application status?

    fill_in 'search', with: @dog1.name
    click_button 'search'

    within("#Pet-Search") do
      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content(@dog1.name)
      expect(page).to_not have_content(@dog2.name)
    end

  end

  it 'can add pets to applications' do
     visit "/applications/#{@app.id}"

    fill_in 'search', with: @dog2.name
    click_button 'search'

    within('#Pet-Search')do
      expect(page).to have_content(@dog2.name)
      expect(page).to have_button("Adopt #{@dog2.name}")
    end

    click_button "Adopt #{@dog2.name}"

    expect(current_path).to eq("/applications/#{@app.id}")

    within('#App-Info') do
      expect(page).to have_content(@dog2.name)
    end
  end

  it 'can submit applications' do
    visit "/applications/#{@app.id}"

   fill_in 'search', with: @dog2.name
   click_button 'search'

   click_button "Adopt #{@dog2.name}"

   expect(page).to have_content('Submit Application')

   within('#Submit-Application') do
     expect(page).to have_content('Why would you make a good owner for these pet(s)?')
     expect(page).to have_field('description')
     click_button 'submit'
   end

   expect(current_path).to eq("/aplications/#{@app.id}")
   expect(page).to have_content('Pending')
   expect(page).to have_content(@dog2.name)
   expect(page).to_not have_content('Why would you make a good owner for these pet(s)?')
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
