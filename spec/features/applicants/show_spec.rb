require 'rails_helper'

RSpec.describe 'the applicant show' do
  before (:each) do
    @greg = Applicant.create!(name: 'Greg Flaherty', street_address: '123 MyStreet St.', city: "Dallas", state: "TX", zipcode: '12345', description: "Love dogs", status: "In progress")
    @no_dog_left_behind = Shelter.create!(name: 'No Dog Left Behind', rank: 1, foster_program: true, city: 'Dallas')
    @jax = @no_dog_left_behind.pets.create!(name: "Jax", age: 1, breed: 'Golden Retriever', adoptable: true)
    @lady = @no_dog_left_behind.pets.create!(name: "Lady", age: 3, breed: 'Ridgeback', adoptable: true)
  end
  it "shows the applicant and all it's attributes" do

    visit "/applicants/#{@greg.id}"

    expect(page).to have_content(@greg.name)
    expect(page).to have_content(@greg.street_address)
    expect(page).to have_content(@greg.city)
    expect(page).to have_content(@greg.state)
    expect(page).to have_content(@greg.zipcode)
    expect(page).to have_content(@greg.description)
    expect(page).to have_content(@greg.status)
  end

  it 'has a text box to filter results by keyword' do
    visit "/applicants/#{@greg.id}"
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")
  end


  it 'provides matches as search results' do
    visit "/applicants/#{@greg.id}"

    fill_in 'Add a Pet to this Application', with: "Jax"
    click_on("Search")
    expect(current_path).to eq("/applicants/#{@greg.id}")
    expect(page).to have_content(@jax.name)
    expect(page).to_not have_content(@lady.name)
  end
end
