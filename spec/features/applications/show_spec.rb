require 'rails_helper'

RSpec.describe "Application show page" do
  before :each do
    @shelter = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    @pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 6, breed: 'rottweiler', name: 'Mose', shelter_id: @shelter.id)
    @application = Application.create(name: 'Jamie', street: '123 S Pearl St', state: "Colorado", city: "Denver", zip_code: "80212", description: "Really loves dogs", status: "Pending")
    PetApplication.create(pet: @pet_1, application: @application)
  end

  it 'displays the applicant name, full address, description, name of all pets applied for and application status' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.zip_code)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.pets.first.name)
    expect(page).to have_content(@application.status)
  end
end
