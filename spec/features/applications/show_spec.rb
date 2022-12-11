# As a visitor
# When I visit an application's show page
# And that application has not been submitted, (status == in progress)
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search

require 'rails_helper'

RSpec.describe 'The application show page' do
  # add visit url to before each
  it 'displays all of the attributes of an application, and all the pets the application is for' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "In Progress")
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    PetApplication.create!(pet: pet_1, application: application)
    PetApplication.create!(pet: pet_2, application: application)

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zipcode)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_link(pet_1.name)
    expect(page).to have_link(pet_2.name)
  end
  
  it 'displays section to add pet to application' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "In Progress")      
                                                   
    visit "/applications/#{application.id}"

    expect(page).to have_content("Add a pet to this application")
  end

  it 'does not display add pet section for submitted applications' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "Pending")
 
    visit "/applications/#{application.id}"

    expect(page).to have_no_content("Add a pet to this application")
  end

  it 'searches for pets and renders results' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "In Progress")
    
    visit "/applications/#{application.id}"
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    fill_in :query, with: 'Lobster'
    click_button 'Search'

    expect(page).to have_content("Lobster")
    expect(current_path).to eq("/applications/#{application.id}")
  end

#   As a visitor
# When I visit an application's show page
# And I search for a Pet by name
# And I see the names Pets that match my search
# Then next to each Pet's name I see a button to "Adopt this Pet"
# When I click one of these buttons
# Then I am taken back to the application show page
# And I see the Pet I want to adopt listed on this application

  it 'contains a button to add a pet to an application' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "In Progress")
    
    visit "/applications/#{application.id}"
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    fill_in :query, with: 'Lobster'
    click_button 'Search'

    expect(page).to have_button("Adopt this pet")

    click_button("Adopt this pet")

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Pets Added to Application:")
    expect(page).to have_link("Lobster")
  end

#   As a visitor
# When I visit an application's show page
# And I have added one or more pets to the application
# Then I see a section to submit my application
# And in that section I see an input to enter why I would make a good owner for these pet(s)
# When I fill in that input
# And I click a button to submit this application
# Then I am taken back to the application's show page
# And I see an indicator that the application is "Pending"
# And I see all the pets that I want to adopt
# And I do not see a section to add more pets to this application
  it 'displays description test field when app is pending and pets added' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      status: "In Progress")
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      PetApplication.create!(pet: pet_1, application: application)
      visit "/applications/#{application.id}"

      expect(page).to have_field("Description")
      fill_in 'Description', with: 'I love pets'
      click_button("Submit")
      application.reload
      expect(current_path).to eq("/applications/#{application.id}")
      expect(application.description).to eq("I love pets")
      expect(application.status).to eq("Pending")
      expect(page).to have_no_content("Adopt this pet")
  end

   it 'does not show submit application button with no pets added' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      status: "In Progress")
      visit "/applications/#{application.id}"
      expect(page).to have_no_content("Submit Application")
   end

#    As a visitor
# When I visit an application show page
# And I search for Pets by name
# Then I see any pet whose name PARTIALLY matches my search
# For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
   it 'displays pets with partial name matches' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "In Progress")
    
    visit "/applications/#{application.id}"
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id) 
    pet_3 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Cecilia', shelter_id: shelter.id) 
    
    expect(page).to have_no_content("Lucille")

    fill_in :query, with: 'cil'
    click_button 'Search'

    expect(page).to have_content("Lucille")
    expect(page).to have_content("Cecilia")
   end
 
   it 'displays pets with case insensitive name matches' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "In Progress")
    
    visit "/applications/#{application.id}"
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id) 
    pet_3 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Cecilia', shelter_id: shelter.id) 
    
    expect(page).to have_no_content("Lucille")

    fill_in :query, with: 'cIL'
    click_button 'Search'

    expect(page).to have_content("Lucille")
    expect(page).to have_content("Cecilia")
   end
  end