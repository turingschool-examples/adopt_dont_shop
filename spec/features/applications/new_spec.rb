require 'rails_helper'

RSpec.describe "Pets edit page" do
  # before :each do
  #   @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   @scooby = @shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
  #   @piglet = @shelter.pets.create!(name: 'Piglet',  age: 1, breed: 'Micro Pig', adoptable: true, shelter_id: @shelter.id)
  #   @garfield = @shelter.pets.create!(name: 'Garfield',  age: 4, breed: 'Orange Tabby Persian', adoptable: true , shelter_id: @shelter.id)
  #
  #   @application_1 = @scooby.applications.create!(name: "Shaggy", address: "2541 Spooky Lane", city: "Coolsville", state: "Ohio", zipcode: "12345", rationale: "I want a best friend to eat scooby snacks with", status: "In Progress")
  # end

  it "links to application page" do

    visit "/pets"
    click_link "New Application"

    expect(current_path).to eq("/applications/new")
  end

  it "can fill and submit a new application" do
    visit '/applications/new'

    fill_in('name', with: "Toto")
    fill_in('address', with: "2745 Nowhere drive")
    fill_in('city', with: "Topeka")
    fill_in('state', with: "Kansas")
    fill_in('zipcode', with: "4279")
    fill_in('rationale', with: "because I would give the dog beer every day")
    fill_in('status', with: "In-progress")

    click_button("Submit Application")

    visit "/applications/#{Application.last.id}"

    expect(page).to have_content("Toto")
    expect(page).to have_content("2745 Nowhere drive")
    expect(page).to have_content("Topeka")
    expect(page).to have_content("Kansas")
    expect(page).to have_content("4279")
    expect(page).to have_content("because I would give the dog beer every day")
    expect(page).to have_content("In-progress")
  end

  it "can redirect user for incomplete form" do
    visit '/applications/new'

    fill_in('name', with: "Toto")
    fill_in('address', with: "2745 Nowhere drive")
    fill_in('city', with: nil)


    click_on("Submit Application")
    expect(current_path).to eq('/applications/new')
    # expect(page).to have_content("Error: City can't be blank, State can't be blank, Zip code can't be blank, Rationale can't be blank, Status can't be blank")
    expect(page).to have_content("Error: Please fill out all fields")

  end
end
