require 'rails_helper'

RSpec.describe "the application show" do
  it "can show the applicant information" do
    application = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome' )
    visit "/applications/#{application.id}"
    # pet = create(:pet)
    # application = create(:application)
    # application_pet = ApplicationPet.create!(pet_id: pet.id, application_id: application.id)
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end

  it "can display all of the names of the pets that this application is for and links that go to the show page" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome')
    pet = application.pets.create!(adoptable: true, age: 6, breed: 'Golden Retreiver', name: "Dog", shelter_id: shelter.id)
    pet2 = application.pets.create!(adoptable: true, age: 7, breed: 'Siamese', name: "Cat", shelter_id: shelter.id)
    pet3 = application.pets.create!(adoptable: true, age: 8, breed: 'No one knows', name: "Moose", shelter_id: shelter.id )


    visit "/applications/#{application.id}"


    fill_in :search, with: 'Dog'

    click_button "Search"

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet2.name)
    expect(page).to have_content(pet3.name)
    expect(page).to have_link("Dog")
    expect(page).to have_link("Cat")
    expect(page).to have_link("Moose")
  end

  it "shows the application status" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome')
    pet = application.pets.create!(adoptable: true, age: 6, breed: 'Golden Retreiver', name: "Dog", shelter_id: shelter.id)
    pet2 = application.pets.create!(adoptable: true, age: 7, breed: 'Siamese', name: "Cat", shelter_id: shelter.id)
    pet3 = application.pets.create!(adoptable: true, age: 8, breed: 'No one knows', name: "Moose", shelter_id: shelter.id )

    visit "/applications/#{application.id}"

    expect(page).to have_content('In Progress')
  end

  it "can visit an appliction that has not been submitted and see a section called Add a Pet to this Aplication" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome')
    pet = application.pets.create!(adoptable: true, age: 6, breed: 'Golden Retreiver', name: "Dog", shelter_id: shelter.id)
    pet2 = application.pets.create!(adoptable: true, age: 7, breed: 'Siamese', name: "Cat", shelter_id: shelter.id)
    pet3 = application.pets.create!(adoptable: true, age: 8, breed: 'No one knows', name: "Moose", shelter_id: shelter.id )

    visit "/applications/#{application.id}"

    expect(page).to have_content('Add a Pet to this Application')
  end

  it "can search for a pet by name and once submitted, user is brought back to the appication show page once submitted. The user now sees the pet name under the search" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome')
    pet = application.pets.create!(adoptable: true, age: 6, breed: 'Golden Retreiver', name: "Dog", shelter_id: shelter.id)
    pet2 = application.pets.create!(adoptable: true, age: 7, breed: 'Siamese', name: "Cat", shelter_id: shelter.id)
    pet3 = application.pets.create!(adoptable: true, age: 8, breed: 'No one knows', name: "Moose", shelter_id: shelter.id )

    visit "/applications/#{application.id}"

    expect(page).to have_content('Search for pets by name')

    expect(page).to have_field(:search)

    fill_in :search, with: 'Dog'

    click_button "Search"

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content('Dog')
  end

  it "can add a pet to the application" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome')
    pet = Pet.create!(adoptable: true, age: 6, breed: 'Golden Retreiver', name: "Fluf", shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 7, breed: 'Siamese', name: "Fluffy", shelter_id: shelter.id)
    pet3 = Pet.create!(adoptable: true, age: 8, breed: 'No one knows', name: "Moose", shelter_id: shelter.id )

    visit "/applications/#{application.id}"

    fill_in :search, with: 'fluf'

    click_button "Search"

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet2.name)
    expect(page).not_to have_content(pet3.name)

    expect(page).to have_button("Adopt this Pet")
    within "#pet-#{pet.id}" do
      click_button "Adopt this Pet"
    end

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content(pet.name)

  end

  it "can submit an application" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome', status: 'In Progress')
    pet = Pet.create!(adoptable: true, age: 6, breed: 'Golden Retreiver', name: "Fluf", shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 7, breed: 'Siamese', name: "Fluffy", shelter_id: shelter.id)
    pet3 = Pet.create!(adoptable: true, age: 8, breed: 'No one knows', name: "Moose", shelter_id: shelter.id )

    visit "/applications/#{application.id}"

    expect(page).not_to have_button('Submit My Application')

    fill_in :search, with: 'Fluf'

    click_button "Search"

    within "#pet-#{pet.id}" do
      click_button "Adopt this Pet"
    end

    expect(page).to have_content('Submit My Application')

    fill_in "description", with: "blahblah"

    click_button "Submit My Application"

    expect(page).to have_content('Pending')
  end


end
