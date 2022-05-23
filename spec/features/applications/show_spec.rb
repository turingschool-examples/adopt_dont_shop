require 'rails_helper'

RSpec.describe "Applications Show Page" do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @scooby = @shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @piglet = @shelter.pets.create!(name: 'Piglet',  age: 1, breed: 'Micro Pig', adoptable: true, shelter_id: @shelter.id)
    @garfield = @shelter.pets.create!(name: 'Garfield',  age: 4, breed: 'Orange Tabby Persian', adoptable: true , shelter_id: @shelter.id)

    @application_1 = Application.create!(name: 'Shaggy', address: '2541 Spooky Lane', city: 'Coolsville', state: 'Ohio', zipcode: '12345', rationale: 'I want a best friend to eat Scooby snacks with', status: 'In-progress')
    @application_2 = Application.create!(name: 'Michael Vick', address: '38747 Brooklyn Lane', city: 'Brooklyn', state: 'New York', zipcode: '11200', rationale: 'I need fighters for my underground dog fight club', status: 'In-progress')
    @application_3 = Application.create!(name: 'Michael Scott', address: '4543 Albuquerque Lane', city: 'Albuquerque', state: 'New Mexico', zipcode: '13579', rationale: 'I am sad and need company', status: 'In-progress')

    # @application_pet1 = ApplicationPet.create!(pet_id: @scooby.id, application_id: @application_1.id)
    # @application_pet2 = ApplicationPet.create!(pet_id: @piglet.id, application_id: @application_2.id)
    # @application_pet3 = ApplicationPet.create!(pet_id: @garfield.id, application_id: @application_3.id)

  end

    it "should display applicant and all their attributes" do
    application_pet1 = ApplicationPet.create!(pet_id: @scooby.id, application_id: @application_1.id)

      visit "applications/#{@application_1.id}"

      expect(page).to have_content("Shaggy")
      expect(page).to have_content("2541 Spooky Lane")
      expect(page).to have_content("Coolsville")
      expect(page).to have_content("Ohio")
      expect(page).to have_content("12345")
      expect(page).to have_content("I want a best friend to eat Scooby snacks with")
      expect(page).to have_content("In-progress")

      expect(page).to have_content(@scooby.name)
      click_link("#{@scooby.name}")

      visit "/pets/#{@scooby.id}"
      expect(current_path).to eq("/pets/#{@scooby.id}")

      expect(page).to have_content('Scooby')
      expect(page).to have_content(2)
      expect(page).to have_content(true)
      expect(page).to have_content("#{@shelter.name}")

  end

  it "it can search for a pet by name" do
    visit "/applications/#{@application_1.id}"
    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(@application_1.status).to eq("In-progress")
    expect(page).to have_content("Add a Pet to this Application")

    within "#search-pet" do
      fill_in with: "#{@scooby.name}"
      click_on "Search Pet Name"
    end

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content(@scooby.name)
  end

  it "can add the searched pet to the application" do
    visit "/applications/#{@application_1.id}"

    within "#search-pet" do
      fill_in with: "#{@scooby.name}"
      click_on "Search Pet Name"
    end

    expect(page).to have_link("Adopt #{@scooby.name}")
    within "#add-pet" do
      click_on "Adopt #{@scooby.name}"
    end

    within "#attributes"
      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content(@scooby.name)
      expect(page).to_not have_content(@piglet.name)
    end
  end
