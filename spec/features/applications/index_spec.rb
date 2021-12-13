require 'rails_helper'

RSpec.describe 'application index page' do
  before :each do
    @shelter = Shelter.create(foster_program: true, name: "shelter_1", city: "Dallas", rank: 1)

    @pet_1 = Pet.create!(adoptable: true, age: 10, breed: "Hound", name: "Pete", shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: false, age: 3, breed: "GSP", name: "Newton", shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 13, breed: "German Shepard", name: "Molly", shelter_id: @shelter.id)

    @application_1 = Application.create!(name: 'Steve', address: '135 Waddle Road', city: 'Dallas', state: 'TX', zip: 75001, description: "I really want a dog", status: "In Progress")
    @application_2 = Application.create!(name: 'Bob', address: '135 Waddle Road', city: 'Culver', state: 'CO', zip: 95013, description: "I really want a dog", status: "Pending")

    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    @pet_application_3 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
  end

  it 'lists all applications as links to show pages' do
    visit '/applications'

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_2.name)

    within("div.app_#{@application_1.id}") do
      click_link "Application #{@application_1.id}"
      expect(current_path).to eq("/applications/#{@application_1.id}")
    end
  end
end
