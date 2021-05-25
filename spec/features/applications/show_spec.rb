

require 'rails_helper'

RSpec.describe 'the application show' do

  # [x] done
  #
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

  it "shows the application and all it's attributes" do
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: 'Looking for a pet', status: "Pending" )
    visit "/applications/#{application_one.id}"

    expect(page).to have_content(application_one.name)
    expect(page).to have_content(application_one.address)
    expect(page).to have_content(application_one.description)
    expect(page).to have_content(application_one.status)
  end

  #   [x] done
  #
  # Searching for Pets for an Application
  #
  # As a visitor
  # When I visit an application's show page
  # And that application has not been submitted,
  # Then I see a section on the page to "Add a Pet to this Application"
  # In that section I see an input where I can search for Pets by name
  # When I fill in this field with a Pet's name
  # And I click submit,
  # Then I am taken back to the application show page
  # And under the search bar I see any Pet whose name matches my search

  it "can search for a pet by name" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: nil, status: "Pending" )
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Jack', shelter_id: shelter.id)
    visit "/applications/#{application_one.id}"

    expect(page).to have_content("Sally Smith")
    expect(page).to have_field(:pet_of_interst_name)
    expect(page).to have_content("In Progress")


    fill_in( "pet_of_interst_name", with: "Jack")
    click_on("Find")

    expect(page).to have_content("Jack")
  end

  #   [x] done
  #
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

  it "can search for a pet by name" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: nil, status: "Pending" )
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Jack', shelter_id: shelter.id)
    visit "/applications/#{application_one.id}"

    expect(page).to have_content("Sally Smith")
    expect(page).to have_field(:pet_of_interst_name)

    fill_in( "pet_of_interst_name", with: "Jack")
    click_on("Find")

    expect(page).to have_content("Jack")
    expect(page).to have_link("Adopt Jack")
    click_on("Adopt Jack")
    expect(page).to have_content("Jack")

    within '#pet_requests' do
      expect(page).to have_content("Jack")
    end
  end

  #   [x] done
  #
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

  it "can post pet for adoption" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: nil, status: "Pending" )
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Jack', shelter_id: shelter.id)
    visit "/applications/#{application_one.id}"

    expect(page).to have_content("In Progress")
    expect(page).to have_content("Sally Smith")
    expect(page).to have_field(:pet_of_interst_name)

    fill_in( "pet_of_interst_name", with: "Jack")
    click_on("Find")

    expect(page).to have_content("Jack")
    expect(page).to have_link("Adopt Jack")
    click_on("Adopt Jack")
    expect(page).to have_content("Jack")

    within '#pet_requests' do
      expect(page).to have_content("Jack")
    end
    expect(page).to have_field(:description)
    fill_in( "description", with: "I would love a new friend.")
    click_on("Submit Adoption Form")
    expect(current_path).to eq("/applications/#{application_one.id}")

    expect(page).to have_content("I would love a new friend.")
    expect(page).to have_content("Pending")
    expect(page).to_not have_field(:pet_of_interst_name)
  end

  #   [ ] done
  #
  # No Pets on an Application
  #
  # As a visitor
  # When I visit an application's show page
  # And I have not added any pets to the application
  # Then I do not see a section to submit my application

  it "will not allow you to bumit a for without pets requested" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: nil, status: "Pending" )
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Jack', shelter_id: shelter.id)
    visit "/applications/#{application_one.id}"

    expect(page).to have_content("In Progress")
    expect(page).to have_content("Sally Smith")

    expect(page).to have_field(:pet_of_interst_name)

    expect(page).to_not have_field(:description)

    fill_in( "pet_of_interst_name", with: "Jack")
    click_on("Find")
    click_on("Adopt Jack")

    expect(page).to have_field(:description)
  end

  # [ ] done

  # Partial Matches for Pet Names
  #
  # As a visitor
  # When I visit an application show page
  # And I search for Pets by name
  # Then I see any pet whose name PARTIALLY matches my search
  # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"

  it 'can find partial matches to pet name' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: nil, status: "Pending" )
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Jack', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Fluffy', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Rascal', shelter_id: shelter.id)
    pet_4 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Applejack', shelter_id: shelter.id)
    visit "/applications/#{application_one.id}"

    fill_in( "pet_of_interst_name", with: "Jack")
    click_on("Find")
    expect(page).to_not have_content("Fluffy")
    expect(page).to_not have_content("Rascal")
    expect(page).to have_content("Applejack")
    expect(page).to have_content("Jack")
  end

  # [ ] done

  # Case Insensitive Matches for Pet Names
  #
  # As a visitor
  # When I visit an application show page
  # And I search for Pets by name
  # Then my search is case insensitive
  # For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"


  it 'can find case insensitive matches' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: nil, status: "Pending" )
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Jack', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Fluffy', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Rascal', shelter_id: shelter.id)
    pet_4 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Applejack', shelter_id: shelter.id)
    visit "/applications/#{application_one.id}"

    fill_in( "pet_of_interst_name", with: "JACK")
    click_on("Find")
    expect(page).to_not have_content("Fluffy")
    expect(page).to_not have_content("Rascal")
    expect(page).to have_content("Applejack")
    expect(page).to have_content("Jack")
  end


end
