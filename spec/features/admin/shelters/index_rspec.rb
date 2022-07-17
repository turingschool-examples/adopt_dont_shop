require 'rails_helper'

RSpec.describe 'the admin shelter index' do
  before :each do
    @shelter_1 = Shelter.create!(name: "ABC Shelter", city: "Nashville", foster_program: true, rank: 1)
    @shelter_2 = Shelter.create!(name: "Denver Shelter", city: "Denver", foster_program: true, rank: 2)
    @shelter_3 = Shelter.create!(name: "Franklin Shelter", city: "Franklin", foster_program: false, rank: 9)
    @shelter_4 = Shelter.create!(name: 'Arizona Shelter', city: 'Tuscon', foster_program: true, rank: 4)
    @pet_1 = Pet.create!(adoptable: true, age: 3, breed: "Goldendoodle", name: "Daisy", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, age: 7, breed: "Terrier", name: "Chewie", shelter_id: @shelter_2.id)
    @pet_3 = Pet.create!(adoptable: true, age: 4, breed: "Poodle", name: "Pepper", shelter_id: @shelter_3.id)
    @application_1 = Application.create!(name: 'John Smith', address: '123 Main Street', city: 'Nashville', state: 'TN', zip: 37067, description: "I want a nice dog.", status: "In Progress")
    @application_2 = Application.create!(name: 'Jim Browning', address: '456 Tree Street', city: 'Denver', state: 'CO', zip: 80127, description: "I love dogs.", status: "Pending")
    @application_3 = Application.create!(name: 'Jessica Jones', address: '789 Boxwood Drive', city: 'Tuscon', state: 'AZ', zip: 85756, description: "I want my other dog to have a friend.", status: "Pending")
    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_2.id)
    @pet_application_3 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_3.id)

  end

  it 'list all shelters in descending alphabetical order' do
    visit "/admin/shelters"

    expect(@shelter_3.name).to appear_before(@shelter_2.name)
    expect(@shelter_2.name).to appear_before(@shelter_4.name)
    expect(@shelter_4.name).to appear_before(@shelter_1.name)
    expect(page).to have_content(@shelter_1.name)
 end

  it 'lists all shelters with pending applications' do
    visit "/admin/shelters"

    expect(page).to have_content("Shelters With Pending Applications")

    within "#shelters-with-pending-apps" do
      expect(page).to have_content(@shelter_2.name)
      expect(page).to have_content(@shelter_3.name)
      expect(page).to_not have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_4.name)
    end
  end
end
