require 'rails_helper'

RSpec.describe 'show page' do
  before(:each) do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Best Shelter", city: "Daytona", rank: 4)
    @application_1 = Application.create!(name: "Freddy Thomas", street: "123 Sesame Street", city: "Daytona", state: "FL", zip_code: "12345", description: "I really love dogs", status: "Pending")
    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 6, breed: "Pug", name: "Lucy")
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "Labradoodle", name: "Leo")

  end

  it 'displays all attributes of the application' do
    PetApplication.create!(application: @application_1, pet: @pet_1)
    PetApplication.create!(application: @application_1, pet: @pet_2)
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_2.name)
  end

  it 'has a section to add a pet to the application' do
    visit "/applications/#{@application_1.id}"
    expect(page).to have_content("Add a Pet to this Application")
    fill_in :search, with: "Lucy"
    click_on "Submit"
    save_and_open_page
    expect(page).to have_content(@pet_1.name)

  end
end
