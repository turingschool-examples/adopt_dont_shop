require 'rails_helper'

RSpec.describe 'the app show page' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)

    @app_1 = Application.create!(name: "Cindy Lou Who", address: "123 Some Street", city: "Whoville", state: "WI", zip: "12345", description: "I'm a who for crying out loud.")
    @app_pet_1 = ApplicationPet.create!(pet: @pet_1, application: @app_1)

    @app_2 = Application.create!(name: "The Grinch", address: "2376 Mountaintop Drive", city: "Whoville", state: "WI", zip: "12345")
    @app_pet_2 = ApplicationPet.create!(pet: @pet_1, application: @app_2)
    @app_pet_3 = ApplicationPet.create!(pet: @pet_2, application: @app_2)
  end

  it 'shows an applicants personal info' do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content("Applicant Name: Cindy Lou Who")
    expect(page).to have_content("Address: 123 Some Street, Whoville, WI 12345")
    expect(page).to have_content("Description: I'm a who for crying out loud.")
    expect(page).to have_content("Pet(s) Applying For:\n#{@pet_1.name}")
    expect(page).to have_content("Application Status: In Progress")
  end

  it 'has a link to each pet applying for' do
    visit "/applications/#{@app_1.id}"

    click_link("Lucille Bald")
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it 'can have multiple links' do
    visit "/applications/#{@app_2.id}"

    expect(page).to have_content("Pet(s) Applying For:\n#{@pet_1.name} #{@pet_2.name}")

    click_link("Lucille Bald")
    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit "/applications/#{@app_2.id}"

    click_link("Lobster")
    expect(current_path).to eq("/pets/#{@pet_2.id}")
  end
end
