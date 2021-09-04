require 'rails_helper'

RSpec.describe 'the new app page' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)

    # @app_1 = Application.create!(name: "Cindy Lou Who", address: "123 Some Street", city: "Whoville", state: "WI", zip: "12345", description: "I'm a who for crying out loud.")
    # @app_pet_1 = ApplicationPet.create!(pet: @pet_1, application: @app_1)
    #
    # @app_2 = Application.create!(name: "The Grinch", address: "2376 Mountaintop Drive", city: "Whoville", state: "WI", zip: "12345")
    # @app_pet_2 = ApplicationPet.create!(pet: @pet_1, application: @app_2)
    # @app_pet_3 = ApplicationPet.create!(pet: @pet_2, application: @app_2)
  end

  it 'has a form to start an app' do
    visit "/applications/new"

    fill_in("name",    with: "Cindy Lou Who")
    fill_in("address", with: "123 Some Street")
    fill_in("city",    with: "Whoville")
    fill_in("state",   with: "WI")
    fill_in("zip",     with: "12345")

    click_button("Submit")

    app_id = Application.last.id

    expect(current_path).to eq("/applications/#{app_id}")
    expect(page).to have_content("Applicant Name: Cindy Lou Who")
    expect(page).to have_content("Address: 123 Some Street, Whoville, WI 12345")
    expect(page).to have_content("")
    expect(page).to have_content("Pet(s) Applying For:")
    expect(page).to have_content("Application Status: In Progress")
  end
end
