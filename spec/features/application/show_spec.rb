require 'rails_helper'

RSpec.describe 'Application Show' do
  before :each do
    @shelter_1 = Shelter.create!(foster_program: true, name: "ABC Shelter", city: "Nashville", rank: 1)
    @pet_1 = Pet.create!(adoptable: true, age: 3, breed: "Goldendoodle", name: "Daisy", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, age: 7, breed: "Terrier", name: "Chewie", shelter_id: @shelter_1.id)
    @pet_3 = Pet.create!(adoptable: true, age: 4, breed: "Poodle", name: "Pepper", shelter_id: @shelter_1.id)
    @pet_4 = Pet.create!(adoptable: true, age: 2, breed: "Labrador", name: "Pepperoni", shelter_id: @shelter_1.id)
    @pet_5 = Pet.create!(adoptable: true, age: 9, breed: "Husky", name: "Ms. PEANUT", shelter_id: @shelter_1.id)
    @application_1 = Application.create!(name: 'John', address: '123 Main Street', city: 'Nashville', state: 'TN', zip: 37067, description: "I want a nice dog.", status: "In Progress")
    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_1 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
end

  it 'shows the applicant and its attributes' do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end


  it "user can search for pets in app's show page when app is in progress" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in :search, with: "#{@pet_1.name}"
    click_on "Search"

    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content("#{@pet_1.name}")
  end

  it 'returns partial matches' do
    visit "/applications/#{@application_1.id}"

    fill_in "Search", with: "pe"
    click_on "Search"

    expect(page).to have_content(@pet_3.name)
    expect(page).to have_content(@pet_4.name)
    expect(page).to have_content(@pet_5.name)
  end

  it 'returns case insensitive matches' do
    visit "/applications/#{@application_1.id}"

    fill_in "Search", with: "peanut"
    click_on "Search"

    expect(page).to have_content(@pet_5.name)
  end

end
