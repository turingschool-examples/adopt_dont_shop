require 'rails_helper'

RSpec.describe 'Application show page' do
  before :each do
    @shelter = Shelter.create(foster_program: true, name: "shelter_1", city: "Dallas", rank: 1)

    @pet_1 = Pet.create(adoptable: true, age: 10, breed: "Hound", name: "Pete", shelter_id: 1)
    @pet_2 = Pet.create(adoptable: false, age: 3, breed: "GSP", name: "Newton", shelter_id: 1)
    @pet_3 = Pet.create(adoptable: false, age: 13, breed: "German Shepard", name: "Molly", shelter_id: 1)

    @pet_application_1 = PetApplication.create(pet_id: 1, application_id: 1)
    @pet_application_2 = PetApplication.create(pet_id: 2, application_id: 1)
    @pet_application_3 = PetApplication.create(pet_id: 5, application_id: 1)

    @application_1 = Application.create(name: 'Steve', address: '135 Waddle Road', city: 'Dallas', state: 'TX', zip: 75001, description: "I really want a dog", status: "In Progress")
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

    expect(page).to have_link("/pets/#{@pet_1.id}")
    expect(page).to have_link("/pets/#{@pet_2.id}")
    expect(page).to have_link("/pets/#{@pet_3.id}")
  end
end
