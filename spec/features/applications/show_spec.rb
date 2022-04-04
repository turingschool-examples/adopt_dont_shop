require 'rails_helper'

RSpec.describe "Applications Show" do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Dorothy', breed: 'pug', age: 5, adoptable: true)

    @application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham", state: "AL", zip_code: "54738", description: 'empty')

    @pet_1.applications << @application_1
    @pet_2.applications << @application_1
  end

  it "shows an application" do
    visit "/applications/#{@application_1.id}"
    # save_and_open_page
    expect(page).to have_content("Carol Crikey")
    expect(page).to have_content("2022 S Fake Street")
    expect(page).to have_content("Birmingham")
    expect(page).to have_content("AL")
    expect(page).to have_content("54738")
    expect(page).to have_content("In Progress")
    expect(page).to have_content("empty")
    expect(page).to have_link("Mr. Pirate")
    expect(page).to have_link("Clawdia")

    click_link("Mr. Pirate")
    # save_and_open_page
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it "has a search bar to add pets to application" do
    visit "/applications/#{@application_1.id}"
    expect(page).to_not have_content('Name: Dorothy')
    expect(page).to_not have_content('Breed: pug')
    expect(page).to_not have_content('Age: 5')

    fill_in 'Search for pet name', with: 'dorothy'
    click_button 'Submit'

    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content('Name: Dorothy')
    expect(page).to have_content('Breed: pug')
    expect(page).to have_content('Age: 5')
  end
end
