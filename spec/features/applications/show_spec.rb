require 'rails_helper'

RSpec.describe 'the application show page' do
  before(:each) do
    Shelter.destroy_all
    Application.destroy_all
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @joan = Application.create(name: "Joan", address: "1234 Cherry St.", city: "Franklin", state:"Pennsylvania", zip_code: 18801, status: "Pending", description: "I am depressed")
    @jane = Application.create(name: "Jane", address: "1234 Cherry St.", city: "Franklin", state:"Pennsylvania", zip_code: 18801, status: "Pending", description: "cat")
    @parker = Application.create(name: "Parker", address: "1234 Cherry St.", city: "Franklin", state:"Pennsylvania", zip_code: 18801, status: "Pending", description: "cat")
    @pet1 = @shelter.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet2 = @shelter.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet3 = @shelter.pets.create(adoptable: true, age: 3, breed: 'maincoon', name: 'george', shelter_id: @shelter.id)
    @pet4 = @shelter.pets.create(adoptable: true, age: 4, breed: 'ragdoll', name: 'gertie', shelter_id: @shelter.id)

    PetApplication.create(pet_id: @pet1.id, application_id: @joan.id)
    PetApplication.create(pet_id: @pet2.id, application_id: @joan.id)
    PetApplication.create(pet_id: @pet3.id, application_id: @jane.id)
    PetApplication.create(pet_id: @pet4.id, application_id: @jane.id)
  end

  it 'shows the name of the Applicant including street, city, state, and zip code ' do
    visit "/applications/#{@joan.id}"

    expect(page).to have_content(@joan.name)
    expect(page).to have_content(@joan.address)
    expect(page).to have_content(@joan.city)
    expect(page).to have_content(@joan.state)
    expect(page).to have_content(@joan.zip_code)
    expect(page).to have_content(@joan.status)
    expect(page).to have_content(@joan.description)
  end

  it 'names all the pets that this application is for' do
    visit "/applications/#{@joan.id}"
    click_link "#{@pet1.name}"
    expect(page).to have_current_path("/pets/#{@pet1.id}")
  end

  it 'Search for a Pet by name for Application' do
    visit "/applications/#{@joan.id}"
    expect(page).to have_content(@joan.name)
    expect(page).to have_content(@joan.address)
    expect(page).to have_content(@joan.city)
    expect(page).to have_content(@joan.state)
    expect(page).to have_content(@joan.zip_code)
    expect(page).to have_content(@joan.status)
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_field("Search")

    fill_in "Search", with: "#{@pet1.name}"
    click_on("Search")

    expect(page).to have_button("Adopt #{@pet1.name}")
    expect(page).to_not have_content("#{@pet3.name}")

    click_on("Adopt #{@pet1.name}")
    expect(page).to have_content("Description")
    expect(page).to have_button("Submit")

    fill_in "Description", with: "I love cats"
    click_on("Submit")
    expect(page).to_not have_content("Search")
  end


  it 'Unable to submit if application doe not have any pets 'do
    visit "/applications/#{@parker.id}"
    expect(page).to_not have_content("Submit")
    expect(page).to have_content("Search")
  end

  it "visit a search bar can match pets with names that contain partial metches" do
    visit "/applications/#{@jane.id}"
      fill_in "Search", with: "ge"
      click_button "Search"
      expect(page).to have_content("#{@pet3.name}")
      expect(page).to have_content("#{@pet4.name}")
      expect(page).to_not have_content("#{@pet2.name}")
  end

  it "visit a search bar can match pets with names that is case insensitive metches" do
    visit "/applications/#{@jane.id}"
      fill_in "Search", with: "GEORGE"
      click_button "Search"
      expect(page).to have_content("#{@pet3.name}")
  end
end
