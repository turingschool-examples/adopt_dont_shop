require 'rails_helper'

RSpec.describe "Application Show Page" do
  before (:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dragon', name: 'Blake C', shelter_id: @shelter_1.id)
    @application = Application.create!(name: "Chaz Carmichael",
      street_address: "10 lane",
      city: "Sandy Springs",
      state: "CO",
      zipcode: 12345)
    @application2 = Application.create!(name: "Kirby",
      street_address: "15 street",
      city: "Jacob Drive",
      state: "DE",
      zipcode: 64523)
  end

  xit "should show applicant information" do
    visit "/application/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street_address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.zipcode)
    expect(page).to have_content(@application.status)
  end

  xit "can display links to pet show page" do
    visit "/application/#{@application.id}"
    fill_in "Enter Pet Name:", with: "Lucille"
    click_on("Search")
    expect(current_path).to eq("/application/#{@application.id}")
    click_on("Adopt this Pet")
    expect(current_path).to eq("/application/#{@application.id}/")
    expect(page).to have_content("Lucille")
  end

  describe "Add a pet section" do
    xit 'has a text box to search pets by name' do
      visit "/application/#{@application2.id}"
      expect(page).to have_button("Search")
    end

    xit "searches for a pet by name and returns to show page with pets who match search" do
      visit "/application/#{@application2.id}"
      fill_in "Enter Pet Name:", with: "Lucille"
      click_on('Search')
      expect(current_path).to eq("/application/#{@application2.id}")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.breed)
      expect(page).to have_content(@pet_1.age)
      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_2.breed)
    end
  end

  describe "Add a pet to an application" do
    xit 'has a button to "Adopt this Pet"' do
      visit "/application/#{@application2.id}"
      fill_in "Enter Pet Name:", with: "l"
      click_on("Search")
      expect(page).to have_link("Adopt this Pet")
      click_on("Adopt this Pet", match: :first)
      expect(current_path).to eq("/application/#{@application2.id}")
      expect(page).to have_content(@pet_1.name)
    end
  end

  describe "Submit an application" do
    it 'has a button to submit an application' do
      visit "/application/#{@application2.id}"
      #Searching for pet
      fill_in "Enter Pet Name:", with: "l"
      click_on("Search")
      expect(page).to have_link("Adopt this Pet")
      click_on("Adopt this Pet", match: :first)
      expect(current_path).to eq("/application/#{@application2.id}")
      #Pet has been added and redirected to show page
      #Expect section to add why owner would make a good home
      expect(page).to have_content("Pets Wanted:\n#{@pet_1.name}")
      expect(page).to have_button("Submit Application")
      fill_in "Why you woud be a good home for these pets:", with: "Cats are cool"
      click_on("Submit Application")
      #Application submitted and redirected to show page
      expect(current_path).to eq("/application/#{@application2.id}")
      expect(page).to have_content("Pending")
      expect(page).to_not have_content("Enter Pet Name:")
      expect(page).to_not have_content("Add a Pet to this Application")
    end
  end
end
