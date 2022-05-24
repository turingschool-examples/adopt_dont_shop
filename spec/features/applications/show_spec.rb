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
      fill_in :search, with: "#{@scooby.name}"
      click_on "Search Pet Name"
    end

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content(@scooby.name)
  end

  it "can add the searched pet to the application" do
    visit "/applications/#{@application_1.id}"

    within "#search-pet" do
      fill_in :search, with: "Scooby"
      click_on "Search Pet Name"
    end

    expect(page).to have_button("Adopt Scooby")
    within "#add-pet" do
      click_button "Adopt Scooby"
    end

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content(@scooby.name)
      expect(page).to_not have_content(@piglet.name)
    end

    it "can submit the application with a description" do
      application_pet1 = ApplicationPet.create!(pet_id: @scooby.id, application_id: @application_1.id)
      application_pet2 = ApplicationPet.create!(pet_id: @piglet.id, application_id: @application_1.id)

      visit "applications/#{@application_1.id}"

      expect(page).to have_field("rationale")
      fill_in :rationale, with: "I love pets"
      click_button "Submit Application"

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_link("Scooby")
      expect(page).to have_content("Piglet")
      expect(page).to have_content("Status: Pending")
      expect(page).to_not have_content("Status: In-Progress")
      expect(page).to_not have_content("Garfield")
      # expect(page).to_not have_field("rationale")
      expect(page).to_not have_field(:search)

  end
end
