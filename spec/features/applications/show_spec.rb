require 'rails_helper'

RSpec.describe "the application show page" do
before(:each) do
  #shelters
  @shelter_1 = Shelter.create(name: "Boulder Humane Society", city: "Boulder, CO", rank: 1, foster_program: "true")
  @shelter_2 = Shelter.create(name: "Denver Humane Society", city: "Denver, CO", rank: 2, foster_program: "false")

  #pets
  @pet1 = @shelter_1.pets.create(name: "Gertie", breed: "Border Collie", adoptable: true, age: 1)
  @pet2 = @shelter_1.pets.create(name: "Millie", breed: "Labrador Retriever", adoptable: true, age: 3)
  @pet3 = @shelter_1.pets.create(name: "Harper", breed: "Lab/Shar Pei/Chow mix", adoptable: false, age: 1)
  @pet4 = @shelter_1.pets.create(name: "fluff", breed: "Pit Pull", adoptable: true, age: 4)
  @pet5 = @shelter_2.pets.create(name: "Mr. Fluff", breed: "Chihuahua", adoptable: true, age: 2)

  #applications
  @app1 = Application.create(name: 'Alice Pieszecki', street: '407 Race St', city: 'Denver', state: 'CO', zip_code: 80305, description: 'A reason', status: 'pending')
  @app2 = Application.create(name: 'Bette Porter', street: '777 Corona St', city: 'Denver', state: 'CO', zip_code: 80221, description: 'B reason', status: 'pending')
  @app3 = Application.create(name: 'Shane McCutchen', street: '1234 Pine Ave', city: 'Arvada', state: 'CO', zip_code: 80218, description: 'C reason', status: 'pending')
  @app4 = Application.create(name: 'Jenny Schecter', street: '2043 21st St', city: 'Denver', state: 'CO', zip_code: 80218, description: 'D reason', status: 'rejected')
  @app5 = Application.create(name: 'Tina Kennard', street: '12 Colorado Blvd', city: 'Denver', state: 'CO', zip_code: 80210, description: 'E reason', status: 'in progress')

  #pet application
  PetApplication.create!(application: @app1, pet: @pet1)
  PetApplication.create!(application: @app2, pet: @pet2)
  PetApplication.create!(application: @app3, pet: @pet3)
  PetApplication.create!(application: @app4, pet: @pet4)



end
  it "shows the application and all its attributes" do
    # Application Show Page
    #
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

    visit ("/applications/#{@app1.id}")

    expect(page).to have_content(@app1.name)
    expect(page).to have_content("Address: #{@app1.street} #{@app1.city}, #{@app1.state} #{@app1.zip_code}")
    expect(page).to have_content("Description: #{@app1.description}")
    expect(page).to have_link(@app1.pets[0].name)
    expect(page).to have_content("Status: #{@app1.status}")

    click_link("#{@app1.pets[0].name}")

    expect(current_path).to eq("/pets/#{@pet1.id}")
  end

  it 'implements a search bar for pet names' do
    # Searching for Pets for an Application

    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search

    visit ("/applications/#{@app1.id}")

    fill_in('search', with: 'Harper')

    click_button("Find this pet!")

    expect(page).to have_content("Search for Pets by Name:")
    expect(page).to have_content("Harper")
  end

  it 'can return pets with only partial matches on the search bar' do
    # Partial Matches for Pet Names
    #
    # As a visitor
    # When I visit an application show page
    # And I search for Pets by name
    # Then I see any pet whose name PARTIALLY matches my search
    # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
    visit ("/applications/#{@app1.id}")

    fill_in('search', with: 'fLuF')

    click_button("Find this pet!")

    expect(page).to have_content("fluff")
    expect(page).to have_content("Mr. Fluff")
  end

  it 'has a working adopt this pet button' do
    # Add a Pet to an Application
    #
    # As a visitor
    # When I visit an application's show page
    # And I search for a Pet by name
    # And I see the names Pets that match my search
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    # When I click one of these buttons
    # Then I am taken back to the application show page
    # And I see the Pet I want to adopt listed on this application
    visit ("/applications/#{@app1.id}")

    fill_in('search', with: 'Harper')

    click_button("Find this pet!")
    click_button("Adopt this Pet")

    expect(page).to have_link("Harper")
  end

  it 'can submit an application' do
    # Submit an Application
    #
    # As a visitor
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
    visit ("/applications/#{@app1.id}")

    expect(page).to have_link("Gertie")
    expect(page).to have_button("Submit Application!")

    fill_in('description', with: 'A very good reason')
    click_button("Submit Application!")

    expect(current_path).to eq("/applications/#{@app1.id}")
    expect(page).to have_content("Status: Pending")
    expect(page).to have_link("Gertie")
    expect(page).to_not have_content("Search for Pets by Name:")
  end

  it 'does not have ability to submit application if no pets have been added' do
    # No Pets on an Application
    #
    # As a visitor
    # When I visit an application's show page
    # And I have not added any pets to the application
    # Then I do not see a section to submit my application
    visit ("/applications/#{@app5.id}")

    expect(page).to_not have_content("Submit Application!")
  end
end
