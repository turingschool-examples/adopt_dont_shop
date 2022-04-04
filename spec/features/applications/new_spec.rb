require 'rails_helper'

RSpec.describe "Applications new page" do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

    @application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham", state: "AL", zip_code: "54738", description: 'empty')

    @pet_1.applications << @application_1
    @pet_2.applications << @application_1
  end

  it "has form to create new application" do
    visit "/applications/new"
    # save_and_open_page
    fill_in('Name', with: 'Carol Crikey')
    fill_in('Street address', with: '2022 S Fake Street')
    fill_in('City', with: 'Birmingham')
    fill_in('State', with: 'AL')
    fill_in('Zip code', with: '54738')
    fill_in('Description', with: "I'm nice")

    click_button("Submit")
    # save_and_open_page
    expect(current_path).to eq("/applications/#{@application_1.id + 1}")
    expect(page).to have_content("Carol Crikey")
    expect(page).to have_content("2022 S Fake Street")
    expect(page).to have_content("Birmingham")
    expect(page).to have_content("AL")
    expect(page).to have_content("54738")
    expect(page).to have_content("In Progress")
  end

  it 're-renders the new form given invalid data' do
    visit "/applications/new"

    click_button("Submit")
    # save_and_open_page
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Description can't be blank")
  end
end
