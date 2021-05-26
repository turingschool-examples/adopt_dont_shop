require 'rails_helper'

RSpec.describe 'the applications show page' do
  before :each do
    @aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @mr_pirate = @aurora.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @aurora.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @kas_application = @mr_pirate.applications.create!(
      first_name: 'Kelly',
      middle_name: 'Anne',
      last_name: 'Simpson',
      street_prefix: 'S',
      street_number: 9382,
      street_name: 'Rose',
      street_type: 'Circle',
      city: 'Arvada',
      state: 'CO',
      zip_code: '89049',
      status: 'In Progress'
    )
    @kas_application.pets << @clawdia
    # ApplicationPet.create!(pet: @mr_pirate, application: @jt_application)
    # ApplicationPet.create!(pet: @clawdia, application: @jt_application)
  end

  it 'shows the applicant and her/his/their application' do
    visit "/applications/#{@kas_application.id}"

    expect(page).to have_content(@kas_application.first_name)
    expect(page).to have_content(@kas_application.middle_name)
    expect(page).to have_content(@kas_application.last_name)
    expect(page).to have_content(@kas_application.street_number)
    expect(page).to have_content(@kas_application.street_prefix)
    expect(page).to have_content(@kas_application.street_name)
    expect(page).to have_content(@kas_application.street_type)
    expect(page).to have_content(@kas_application.city)
    expect(page).to have_content(@kas_application.state)
    expect(page).to have_content(@kas_application.zip_code)
    expect(page).to have_content(@kas_application.status)

    # expect(page).to have_content(@mr_pirate.name)
    # expect(page).to have_content(@clawdia.name)

    # find("pet_id-#{@mr_pirate.id}").
    # click_link(@mr_pirate.name)
    # expect(current_path).to eq("/pets/#{@mr_pirate.id}")
  end

  it 'has a search field' do
    visit "/applications/#{@kas_application.id}"

    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/applications/#{@kas_application.id}"

    fill_in 'Search', with: "ba"
    click_on("Search")

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end

  it 'can add pet to application' do
    @tkt_application = Application.create!(
      first_name: 'Timothy',
      middle_name: 'Kelly',
      last_name: 'Tyson',
      street_number: 8399,
      street_name: 'Thomas',
      street_type: 'Lane',
      city: 'Arvada',
      state: 'CO',
      zip_code: '89049',
      status: 'In Progress'
    )
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/applications/#{@tkt_application.id}"

    fill_in 'Search', with: "ba"
    click_on("Search")
    click_button("Adopt #{pet_1.name}")

    expect(page).to have_content("List of Pets You Want to Adopt")
    expect(page).to_not have_content("Adopt #{pet_1.name}")
  end  
end
