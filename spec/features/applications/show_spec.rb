require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all its attributes" do
    application = Application.create!(
      name: "Jerry Blank",
      street_address: "246 DumDum Ave.",
      city: "Melbourne",
      state: "IL",
      zip_code: 53262,
      description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
      status: "In Progress"
    )

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end

  it "shows the pets that the application is for and links to their show page" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pirate = shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    claw = shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    joey = shelter.pets.create(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)

    app = Application.create!(
      name: "Jerry Blank",
      street_address: "246 DumDum Ave.",
      city: "Melbourne",
      state: "IL",
      zip_code: 53262,
      description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
      status: "In Progress"
    )

    PetApplication.create!(pet_id: pirate.id, application_id: app.id)
    PetApplication.create!(pet_id: claw.id, application_id: app.id)
    PetApplication.create!(pet_id: joey.id, application_id: app.id)

    visit "/applications/#{app.id}"

    expect(page).to have_link(pirate.name)
    click_link(pirate.name)

    expect(current_path).to eq("/pets/#{pirate.id}")

    visit "/applications/#{app.id}"
    expect(page).to have_link(claw.name)
    click_link(claw.name)
    expect(current_path).to eq("/pets/#{claw.id}")

    visit "/applications/#{app.id}"
    expect(page).to have_link(joey.name)
    click_link(joey.name)
    expect(current_path).to eq("/pets/#{joey.id}")

  end
end

RSpec.describe 'Adding pets to an application' do
  describe 'US 23: Searching for Pets' do
    before :each do
      @app_1 = Application.create!(
        name: "Jerry Blank",
        street_address: "246 DumDum Ave.",
        city: "Melbourne",
        state: "IL",
        zip_code: 53262,
        description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
        status: "In Progress"
      )

      @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pirate = @shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @gaspir = @shelter.pets.create(name: 'Gaspir', breed: 'shorthair', age: 3, adoptable: true)
      @joey = @shelter.pets.create(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)
    end

    it 'has a search field on applications that have not been submitted' do

      app_2 = Application.create!(
        name: "Jeff Jippers",
        street_address: "123 Affirmative Ave.",
        city: "Claytown",
        state: "AL",
        zip_code: 34567,
        description: "I'm a good doggie daddy!",
        status: "Pending"
      )

      visit "/applications/#{@app_1.id}"
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_button("Submit")

      visit "/applications/#{app_2.id}"
      expect(page).to_not have_content("Add a Pet to this Application")
      expect(page).to_not have_button("Submit")
    end

    it 'searches for animals by name' do

      visit "/applications/#{@app_1.id}"
      fill_in("Lookup by Name", with: "pir")
      click_button("Submit")

      expect(current_path).to eq("/applications/#{@app_1.id}")
      expect(page).to have_content(@pirate.name)
      expect(page).to have_content(@gaspir.name)
      expect(page).to_not have_content(@joey.name)
    end
  end

  describe 'US 22: Adding pets' do
    before :each do
      @app_1 = Application.create!(
        name: "Jerry Blank",
        street_address: "246 DumDum Ave.",
        city: "Melbourne",
        state: "IL",
        zip_code: 53262,
        description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
        status: "In Progress"
      )

      @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pirate = @shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @gaspir = @shelter.pets.create(name: 'Gaspir', breed: 'shorthair', age: 3, adoptable: true)
      @joey = @shelter.pets.create(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)


      visit "/applications/#{@app_1.id}"
      fill_in("Lookup by Name", with: "Pirate")
      click_button("Submit")

      click_button "Adopt Me"
    end

    it 'shows the pet as being added to the application' do

      expect(current_path).to eq("/applications/#{@app_1.id}")

      within("#added_pets") do
        expect(page).to have_content(@pirate.name)
      end
      # expect(page).to_not have_content("#{@gaspir.name}")
    end

    it 'can have multiple pets added' do

      fill_in("Lookup by Name", with: "Gaspir")
      click_button("Submit")

      click_button "Adopt Me"

      expect(current_path).to eq("/applications/#{@app_1.id}")
      within("#added_pets") do
        expect(page).to have_content(@pirate.name)
        expect(page).to have_content(@gaspir.name)
      end

      fill_in("Lookup by Name", with: "Joey")
      click_button("Submit")

      click_button "Adopt Me"

      expect(current_path).to eq("/applications/#{@app_1.id}")

      within("#added_pets") do
        expect(page).to have_content(@pirate.name)
        expect(page).to have_content(@gaspir.name)
        expect(page).to have_content(@joey.name)
      end
    end

    xit 'removes added pets from search results' do
      fill_in("Lookup by Name", with: "pir")
      click_button("Submit")

      within("#results") do
        expect(page).to_not have_content(@pirate.name)
        expect(page).to have_content(@gaspir.name)
      end
    end
  end
end
