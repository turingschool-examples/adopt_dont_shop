require 'rails_helper'

RSpec.describe 'application show page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @simba = @shelter_1.pets.create(name: 'simba', age:12, breed: 'Doberman', adoptable: true)
    @terry = @shelter_1.pets.create(name: 'Terry', age:3, breed: 'Hot Dog', adoptable: true)
    @application_1 = Application.create(name: "Jose Molina", street_address: "345 Colfax Ave", city: "Denver", state: "CO", zip_code: "80203", description: "I want a cat")
  end

  it 'visits application show page and sees attributtes' do

    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@application_1.description)

  end


it 'has a section on the page with input to search for pets' do

  visit "/applications/#{@application_1.id}"

  expect(@application_1.pets).to eq([])
  expect(page).to_not have_content("Why you would be a good owner?")
end

it 'without pets, application cannot be submitted' do
  visit "/applications/#{@application_1.id}"

  fill_in :search_for_pets_by_name, with: "simba"

  click_on "Submit"
  expect(current_path).to eq("/applications/#{@application_1.id}")
  expect(page).to have_content("simba")

end

it "shows searched pets names" do
  visit "/applications/#{@application_1.id}"

  fill_in :search_for_pets_by_name, with: "simba"

  click_button("Submit")
  expect(current_path).to eq("/applications/#{@application_1.id}")
  expect(page).to have_content("simba")
end

it "case insensitive" do
  fill_in :search_for_pets_by_name, with: "Simba"

  click_button("Submit")
  expect(current_path).to eq("/applications/#{@application_1.id}")
  expect(page).to have_content("simba")
end

  it 'can add pet to application' do


    visit "/applications/#{application_1.id}"

    expect(page).to have_content("Search for pets by name")
    fill_in :search_for_pets_by_name, with: "simba"

    click_on "Submit"

    click_button "Adopt this pet"

    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(application_1.pets.first).to eq(pet_1)
  end


  it 'can submit an application' do


    visit "/applications/#{@application_1.id}"

    fill_in :search_for_pets_by_name, with: "simba"

    click_button("Submit")

    click_button "Adopt this pet"

    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content("What makes you a good owner?")
  end

  it "can adopt multiple pets and submit" do

    fill_in :search_for_pets_by_name, with: "Terry"

    click_button("Submit")

    click_button "Adopt this pet"

    fill_in :description, with: "I want some dogs"

    click_button("Submit")

    expect(current_path).to eq("/applications/#{@application_1.id}")

    expect(@application_1.pets.count).to eq(2)
    expect(@application_1.pets).to eq([@simba, @terry])
    expect(page).to have_link("simba")
    expect(page).to have_link("Terry")
  end

end
