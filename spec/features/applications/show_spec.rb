require 'rails_helper'

RSpec.describe 'Applications show page' do
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter.id)
    @app_1 = Application.create!(name: "Erika Kischuk", address: "455 Villa Ct. Morrison, CO 80228", description: "I love animals", status: "In Progress")
    @app_2 = Application.create!(name: "Kate Hill", address: "67 S Montgomery St. Lakewood, CO 80227", description: "Dogs love me!", status: "In Progress")
    @app_3 = Application.create!(name: "Sarah Leander", address: "889 N West St. Denver, CO 80226", description: "My house always smells like food", status: "Pending")
  end

  it 'displays application and attributes' do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_3
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_1.address)
    expect(page).to have_content(@app_1.description)
    expect(page).to have_content(@app_1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_3.name)
    expect(page).to_not have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_4.name)
  end

  it 'has links to each pet show page' do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_3
    visit "/applications/#{@app_1.id}"

    within("#application-pets") do
      click_on "#{@pet_1.name}"
      expect(current_path).to eq("/pets/#{@pet_1.id}")
    end
    visit "/applications/#{@app_1.id}"

    within("#application-pets") do
      click_on "#{@pet_3.name}"
      expect(current_path).to eq("/pets/#{@pet_3.id}")
    end
  end

  it 'has search for pets section for in progress form' do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")

    fill_in 'Search', with: "er"
    click_on "Search"

    expect(page).to have_content("Lobster")
    expect(page).to have_content("Sylvester")
  end

  it 'has no search for applications not in progress' do
    visit "/applications/#{@app_3.id}"

    expect(page).to_not have_content("Add a Pet to this Application")
    expect(page).to_not have_button("Search")
  end

  it 'has button to add pets' do
    visit "/applications/#{@app_1.id}"

    fill_in 'Search', with: "er"
    click_on "Search"

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_button("Adopt this Pet")
      click_on "Adopt this Pet"
    end

    expect(current_path).to eq("/applications/#{@app_1.id}")
    expect(page).to have_content(@pet_2.name)
  end

  it 'has submit section for applications with pets' do
    visit "/applications/#{@app_1.id}"
    expect(page).to_not have_content("Why would you make a good pet owner?")
    expect(page).to_not have_button("Submit Application")

    @app_1.pets << @pet_1
    @app_1.pets << @pet_3

    visit "/applications/#{@app_1.id}"
    expect(page).to have_content("Why would you make a good pet owner?")
    fill_in 'Description', with: "Because my house always smells like food and Bare-y and Sylvester would love that."
    click_on "Submit Application"

    expect(current_path).to eq("/applications/#{@app_1.id}")
    expect(page).to_not have_content("Why would you make a good pet owner?")
    expect(page).to_not have_button("Submit Application")
    expect(page).to have_content("Status: Pending")
    save_and_open_page
  end
end
