require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_content('Applying for pet: Spot')
  end

  it "searches for pets and adds them to an application" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    chungus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Chungus', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'In Progress')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)

    visit "/applications/#{application.id}"
    expect(page).to have_content("Add a Pet to this Application")

    fill_in 'Search', with: 'Spot'
    click_button 'Submit'

    expect(current_path).to eq("/applications/#{application.id}/")

    expect(page).to have_content("Spot")
    expect(page).to_not have_content("Chungus")
  end

  it "search results have an adopt this pet button" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    chungus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Chungus', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'In Progress')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)

    visit "/applications/#{application.id}"
    expect(page).to have_content("Add a Pet to this Application")

    fill_in 'Search', with: 'Chungus'
    click_button 'Submit'

    expect(current_path).to eq("/applications/#{application.id}/")

    expect(page).to have_button("Adopt this Pet")
  end

  it "adopt this pet button adds a pet to the application" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    chungus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Chungus', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'In Progress')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)

    visit "/applications/#{application.id}"
    expect(page).to have_content("Add a Pet to this Application")

    fill_in 'Search', with: 'Chungus'
    click_button 'Submit'
    click_button 'Adopt this Pet'
    expect(page).to have_content("Applying for pet: Chungus")
  end

  it "has a section to sumbit an application" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    chungus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Chungus', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', status: 'In Progress')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)

    visit "/applications/#{application.id}"


    expect(page).to have_button("Submit this Application")
    expect(page).to have_field(:description)


  end

  it "application changes description" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    chungus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Chungus', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', status: 'In Progress')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
    visit "/applications/#{application.id}"

    fill_in :description, with: 'New description'
    click_button 'Submit this Application'


    expect(page).to have_content("Pending")
    expect(page).to have_content("New description")
    expect(page).to_not have_button("Submit this Application")
    expect(page).to_not have_field(:description)
  end

  it "no submit section when there is no pets" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', status: 'In Progress')
    visit "/applications/#{application.id}"

    expect(page).to_not have_button("Submit this Application")
    expect(page).to_not have_field(:description)
  end

  it "can search with fragments" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    chungus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Chungus', shelter_id: shelter[:id])
    gus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Gus', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', status: 'In Progress')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
    visit "/applications/#{application.id}"

    fill_in 'Search', with: 'us'
    click_button 'Submit'

    expect(page).to have_content(chungus.name)
    expect(page).to have_content(gus.name)
  end

  it "searches are case insensitive" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    chungus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Chungus', shelter_id: shelter[:id])
    gus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Gus', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', status: 'In Progress')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
    visit "/applications/#{application.id}"

    fill_in 'Search', with: 'ChUnGuS'
    click_button 'Submit'

    expect(page).to have_content(chungus.name)
  end
end
