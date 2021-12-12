require 'rails_helper'

RSpec.describe 'create an application' do
  before :each do
    @shelter = Shelter.create(foster_program: true, name: "shelter_1", city: "Dallas", rank: 1)

    @pet_1 = Pet.create!(adoptable: true, age: 10, breed: "Hound", name: "Pete", shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: false, age: 3, breed: "GSP", name: "Newton", shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 13, breed: "German Shepard", name: "Molly", shelter_id: @shelter.id)

    @application_1 = Application.create!(name: 'Steve', address: '135 Waddle Road', city: 'Dallas', state: 'TX', zip: 75001, description: "I really want a dog", status: "In Progress")

    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    @pet_application_3 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
  end

  it 'application form links from pet index page' do
    visit '/pets'
    expect(page).to have_link("Start an Application")
    click_link("Start an Application")
    expect(current_path).to eq('/applications/new')
  end

  it 'has form that creates a new application' do
    visit '/applications/new'

    fill_in "Name", with: 'Steve'
    fill_in "Street Address", with: '135 Waddle Road'
    fill_in "City", with: "Dallas"
    fill_in "State", with: 'TX'
    fill_in "Zip Code", with: 75001
    click_button "Submit"

    application = Application.last
    expect(current_path).to eq("/applications/#{application.id}")
    expect(current_path).to have_content("In Progress")
  end
end
