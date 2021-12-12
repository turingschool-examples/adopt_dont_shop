require 'rails_helper'

RSpec.describe 'Application show page' do
  before :each do
    @shelter = Shelter.create!(foster_program: true, name: "shelter_1", city: "Dallas", rank: 1)

    @pet_1 = Pet.create!(adoptable: true, age: 10, breed: "Hound", name: "Pete", shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: false, age: 3, breed: "GSP", name: "Newton", shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 13, breed: "German Shepard", name: "Molly", shelter_id: @shelter.id)

    @application_1 = Application.create(name: 'Steve', address: '135 Waddle Road', city: 'Dallas', state: 'TX', zip: 75001, description: "I really want a dog", status: "In Progress")

    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    @pet_application_3 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)


  end
  it "shows all attributes of the application" do
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
    expect(page).to have_content(@pet_3.name)
  end

  it "has links to the show page of each pet being applied for" do
    visit "/applications/#{@application_1.id}"
    click_link("#{@pet_1.name}")
    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit "/applications/#{@application_1.id}"
    click_link("#{@pet_2.name}")
    expect(current_path).to eq("/pets/#{@pet_2.id}")

    visit "/applications/#{@application_1.id}"
    click_link("#{@pet_3.name}")
    expect(current_path).to eq("/pets/#{@pet_3.id}")
  end
end
