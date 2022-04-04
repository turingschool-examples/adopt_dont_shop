require 'rails_helper'

RSpec.describe "Application Show Page" do

  before :each do
    @application_1 = Application.create!(name: 'Alex Horn', street_address: '12 Not A Real Ln', city: 'Westminster', state: 'CO', zip_code: '80021')
    @application_2 = Application.create!(name: 'Bob Ross', street_address: '21 Happy Tree Ln', city: 'Daytona Beach', state: 'FL', zip_code: '32122')
    @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_3 = Pet.create!(name: 'Daisy', age: 4, breed: 'American Bully', adoptable: true, shelter_id: @shelter.id)
    @pets_applications_1 = ApplicationsPet.create!(pet_id: @pet_3.id, application_id: @application_1.id)
    @pets_applications_2 = ApplicationsPet.create!(pet_id: @pet_2.id, application_id: @application_1.id)

  end

  it "show page shows applicant info" do
    visit "/applications/#{@application_2.id}/"

    expect(page).to have_content(@application_2.name)
    expect(page).to have_content(@application_2.street_address)
    expect(page).to have_content(@application_2.city)
    expect(page).to have_content(@application_2.state)
    expect(page).to have_content(@application_2.zipcode)
    expect(page).to have_content(@application_2.why_me)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_link(href: "/pets/#{@pet_1.id}/")
    expect(page).to have_content("In Progress")
  end

  xit "show page (unsubmitted) has search field for pet's name" do

    visit "/applications/#{@application_1.id}/"

    expect(page).not_to have_content(@pet_1.name)

    fill_in :find_pet, with: "Moose"
    click_on :search

    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).not_to have_content("@pet_1.name")
    expect(page).not_to have_content("@pet_2.name")

    fill_in :find_pet, with: "Scooby"
    click_on :search

    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content("@pet_1.name")
    # We may decide to add other pet atributes here?
  end
end
