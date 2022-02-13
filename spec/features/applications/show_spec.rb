require 'rails_helper'

RSpec.describe 'the applications show page' do
  before :each do
    @shelter = Shelter.create(name: 'Maxfund', city: 'Denver CO', foster_program: false, rank: 9)
    @application_1 = Application.create!(name: "Holden Caulfield", street_address: "123 Main St", city: "New York", state: "NY", zipcode: 12345, description: "I wouldn't be a good pet owner", status: "In Progress")
    @pet_1 = Pet.create(adoptable: true, age: 2, breed: 'domestic short hair', name: 'Mundungous', shelter_id: "#{@shelter.id}")
    @pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Captain Pants', shelter_id: "#{@shelter.id}")
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: 'domestic long hair', name: 'Hogan', shelter_id: "#{@shelter.id}")

    @pet_app = PetApplication.create!(pet: @pet_1, application: @application_1)
    @pet_app_2 = PetApplication.create!(pet: @pet_2, application: @application_1)
  end

  it "shows the application and all it's attributes" do

    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zipcode)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@application_1.status)
  end

  it 'includes a link to each pet page' do
    visit "/applications/#{@application_1.id}"

    click_on("#{@pet_1.name}")
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it 'in progress application - has Add Pets section' do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content("In Progress")
    expect(page).to have_content("Add Pet to this Application")
  end

  it 'search for pets by name' do
    visit "/applications/#{@application_1.id}"

    expect(find('form')).to have_content('Search for Pets')

    fill_in(:search, with: 'Captain Pants')

    click_button("Search")

    expect(current_path).to eq("/applications/#{@application_1.id}")
    within('div.pet_search') do
      expect(page).to have_content('Captain Pants')
    end
  end

  it 'Adopt this Pet Button appears next to each pet - adds pet to app' do
    visit "/applications/#{@application_1.id}"

    within("#pets_on_app") do
      expect(page).to_not have_content('Hogan')
    end

    fill_in(:search, with: 'Hogan')
    click_button("Search")

    within("#app_pet_link-#{@pet_3.id}") do
      click_button("Adopt this Pet")
    end

    expect(current_path).to eq("/applications/#{@application_1.id}")

    within("#pets_on_app") do
      expect(page).to have_content("#{@pet_3.name}")
    end
  end
end
