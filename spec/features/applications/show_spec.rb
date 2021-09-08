# spec/features/applications/show_spec.rb
require 'rails_helper'

RSpec.describe 'application show page' do
  before(:each) do
    @app_1 = Application.create!(
      name: "Sarah Carter",
      address: "1108 Ichabod St",
      city: "North Pole",
      state: "Alaska",
      zip: "99705")
    @shelter = Shelter.create!(name: 'Cheyenne Animal Shelter', city: 'Cheyenne', foster_program: false, rank: 2)
    @pet_1 = @shelter.pets.create!(name: 'Cassio', age: 2, breed: 'Akbash', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(name: 'Bianca', age: 1, breed: 'Great Pyrenees',  adoptable: true, shelter_id: @shelter.id)

  end

  it "displays all the applicant params and the app status" do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2

    visit "/applications/#{@app_1.id}"

    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_1.address)
    expect(page).to have_content(@app_1.city)
    expect(page).to have_content(@app_1.state)
    expect(page).to have_content(@app_1.zip)
    expect(page).to have_content(@app_1.status)
    expect(page).to have_content(@app_1.description)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@pet_2.name}")

    click_link("#{@pet_1.name}")
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end

  it "can look up a pet by name" do
    visit "/applications/#{@app_1.id}"

    fill_in "Search Pet Name:", with: "Bianca"
    click_on "Search"

    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.age)
    expect(page).to have_content(@pet_2.breed)
  end

  it "can add pet to application" do
    visit "/applications/#{@app_1.id}"

    fill_in "Search Pet Name:", with: "#{@pet_2.name}"
    click_on "Search"

    within("##{@pet_2.name}_#{@pet_2.id}") do
      click_button("Adopt this Pet!")
    end

    expect(@app_1.pets).to include(@pet_2)
  end

  it "can add description and submit application" do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_no_content("Why would you be a good pet parent?")
    expect(page).to have_content("In Progress")
    expect(@app_1.description).to eq(nil)

    fill_in "Search Pet Name:", with: "#{@pet_2.name}"
    click_on "Search"

    within("##{@pet_2.name}_#{@pet_2.id}") do
      click_button("Adopt this Pet!")
    end

    expect(page).to have_content("Why would you be a good pet parent?")

    fill_in :description, with: "I will name him George, and I will hug him, and pet him, and squeeze him"
    click_on("Complete Application")

    expect(page).to have_no_content("Add a Pet to Application")
    expect(page).to have_no_content("Search Pet Name:")
    expect(page).to have_no_content("Complete Application")
    expect(page).to have_no_content("Why would you be a good pet parent?")
    expect(page).to have_content("Pending")
    expect(page).to have_content(@pet_2.name)
  end

  it "can find pets by name on a partial name match and isn't case sensitive" do
    visit "/applications/#{@app_1.id}"

    fill_in "Search Pet Name:", with: "cass"
    click_on "Search"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.breed)

    visit "/applications/#{@app_1.id}"

    fill_in "Search Pet Name:", with: "BIANCA"
    click_on "Search"

    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.age)
    expect(page).to have_content(@pet_2.breed)
  end
end
