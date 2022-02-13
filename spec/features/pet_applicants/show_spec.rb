require 'rails_helper'

RSpec.describe 'add pet to application' do
  before (:each) do
    @greg = Applicant.create!(name: 'Greg Flaherty', street_address: '123 MyStreet St.', city: "Dallas", state: "TX", zipcode: '12345', description: "Love dogs", status: "In progress")
    @no_dog_left_behind = Shelter.create!(name: 'No Dog Left Behind', rank: 1, foster_program: true, city: 'Dallas')
    @jax = @no_dog_left_behind.pets.create!(name: "Jax", age: 1, breed: 'Golden Retriever', adoptable: true)
    @lady = @no_dog_left_behind.pets.create!(name: "Lady", age: 3, breed: 'Ridgeback', adoptable: true)
  end
  it "cann add pet to application" do

    visit "/applicants/#{@greg.id}"

    fill_in 'Add a Pet to this Application', with: "Jax"
    click_on("Search")
    expect(current_path).to eq("/applicants/#{@greg.id}")
    within "#pet-#{@jax.id}" do
      expect(page).to have_button("Adopt this Pet")
      click_on "Adopt this Pet"
    end
  end

  it 'clicks on "Adopt this Pet and adds that pet to applicants pets"' do
    visit "/applicants/#{@greg.id}"

    fill_in 'Add a Pet to this Application', with: "Jax"
    click_on("Search")
    expect(current_path).to eq("/applicants/#{@greg.id}")

    within "#pet-#{@jax.id}" do
      expect(page).to have_button("Adopt this Pet")
      click_on "Adopt this Pet"
    end

    expect(current_path).to eq("/applicants/#{@greg.id}")
    save_and_open_page
    expect(page).to have_content("Pets on application: ")
    expect(page).to have_content("Jax")
    expect(page).to_not have_content("Lady")
  end
end
