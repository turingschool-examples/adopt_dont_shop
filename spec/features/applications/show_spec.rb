require "rails_helper"

RSpec.describe 'applications show page' do

  before:each do
    @application_1 = Application.create!(name: 'Pam Pulzone', street_address: '66225 Wallace Rd', city: 'Bend', state: 'OR', zip: 97702, description: 'Fenced yard, loving home', status: 'Pending')
    @application_2 = Application.create!(name: 'Dan Boston', street_address: '774 Boone Rd', city: 'Greenville', state: 'SC', zip: 56843, description: 'Experience with difficult dogs', status:  'In Progress')
    @shelter_1= Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'HSCO', city: 'Bend, OR', foster_program: true, rank: 4)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: false, age: 8, breed: 'mix', name: 'Kumquat', shelter_id: @shelter_2.id)
   
  end

  it 'it shows details of the application' do
    
    visit "/applications/#{@application_1.id}"
    
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    
    expect(page).to_not have_content(@application_2.name)
  end
  
  it 'shows a search field to add pets to an applicaiton' do
    visit "/applications/#{@application_1.id}"
    
    fill_in 'Search', with: 'Lo'
    click_on 'Search'

    expect(page).to have_content(@pet_2.name)
    
    expect(page).to_not have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_3.name)
  end

  it "has an 'Adopt this Pet' button next to each animal name that matches search criteria" do
    visit "/applications/#{@application_1.id}"
    
    fill_in 'Search', with: 'L'
    click_on 'Search'

    within("#{@pet_1.id}") do
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_button("Adopt this Pet")
    click_button "Adopt this Pet"
binding.pry
    expect(current_path).to eq("/applications/#{@application.id}/edit")
  end 
    
    # within("#applications-#{@pet_2.id}")
    # expect(page).to have_content(@pet_2.name)
    # expect(page).to have_button("Adopt this Pet")
    
    
  end
end