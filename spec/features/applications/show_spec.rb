require 'rails_helper'

RSpec.describe 'the application show' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    status = ["In Progress", "Pending", "Accepted", "Rejected"]
    @application_1 = Application.create!(
      name: Faker::Name.unique.name,
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip_code: Faker::Address.zip_code,
      description: Faker::Company.bs,
      status: "In Progress"
    )
    ApplicationPet.create!(application: @application_1, pet: @pet_1)
  end

  it "shows an application and all of it's attribues" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@pet_1.name)
  end

  it "displays a section to add a pet to the application prior to submission" do
    visit "/applications/#{@application_1.id}"

    fill_in "Search by name", with: 'Clawdia'
    click_on 'Search'

    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_content("Clawdia")
    expect(page).to_not have_content("Lucille Bald")
    end
  end
