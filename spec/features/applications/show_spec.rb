require 'rails_helper'

RSpec.describe 'the applications show page' do
  before :each do
    @brighter_days = Shelter.create!(name: 'Brighter Days Shelter', rank: 1, city: 'Boulder', foster_program: true)
    @underdogs = Shelter.create!(name: 'Underdogs Shelter', rank: 2, city: 'Denver', foster_program: true)

    @bosco = @brighter_days.pets.create!(name: 'Bosco', adoptable: true, age: 8, breed: 'Springer Spaniel')
    @lily = @brighter_days.pets.create!(name: 'Lily', adoptable: true, age: 5, breed: 'German Shepard Boxer Mix')

    @izze = @underdogs.pets.create!(name: 'Izze', adoptable: true, age: 8, breed: 'Cocker Spaniel')
    @zephyr = @underdogs.pets.create!(name: 'Zephyr', adoptable: true, age: 8, breed: 'Malamute')
    @ruger = @underdogs.pets.create!(name: 'Ruger', adoptable: true, age: 8, breed: 'Husky Samoyed Mix')

    @app_1 = Application.create!(name: 'Elliot O.', street: '5743 Squirrel Circle', city: 'Aspen', state: 'CO', zip_code: 81611, application_status: 'Pending', description: 'loves animals')
    @app_2 = Application.create!(name: 'Sami P.', street: '1123 Arbor Lane', city: 'Chicago', state: 'IL', zip_code: 60007, application_status: 'Approved', description: 'loving home')
    @app_3 = Application.create!(name: 'Amanda M.', street: '883 Teller Court', city: 'Wheat Ridge', state: 'CO', zip_code: 80033, application_status: 'Pending', description: 'active family')

    @pet_app_1 = PetApplication.create!(pet: @bosco, application: @app_1)
    @pet_app_2 = PetApplication.create!(pet: @lily, application: @app_1)
    @pet_app_3 = PetApplication.create!(pet: @izze, application: @app_2)
    @pet_app_4 = PetApplication.create!(pet: @zephyr, application: @app_2)
    @pet_app_5 = PetApplication.create!(pet: @ruger, application: @app_3)
  end

  it 'can display the name, full address, description, pet(s) applied for, and status of the application' do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content("#{@app_1.name}'s Application")
    expect(page).to have_content("Street: #{@app_1.street}")
    expect(page).to have_content("City: #{@app_1.city}")
    expect(page).to have_content("State: #{@app_1.state}")
    expect(page).to have_content("Zip Code: #{@app_1.zip_code}")
    expect(page).to have_content("Description: #{@app_1.description}")
    expect(page).to have_content("Pet(s) Applied For: #{@pet_app_1.pet.name} , #{@pet_app_2.pet.name}")
    expect(page).to have_content("Application Status: #{@app_1.application_status}")
  end

  it 'can link to each pets show page in the pets applied for section' do
    visit "/applications/#{@app_1.id}"

    click_link("Bosco")

    expect(current_path).to eq("/pets/#{@bosco.id}")

    visit "/applications/#{@app_1.id}"

    click_link("Lily")

    expect(current_path).to eq("/pets/#{@lily.id}")
  end
end
