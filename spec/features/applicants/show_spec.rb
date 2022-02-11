require 'rails_helper'

RSpec.describe 'the applicant show' do
  before (:each) do
    @greg = Applicant.create!(name: 'Greg Flaherty', street_address: '123 MyStreet St.', city: "Dallas", state: "TX", zipcode: '12345', description: "Love dogs", status: "In progress")
    @no_dog_left_behind = Shelter.create!(name: 'No Dog Left Behind', rank: 1, foster_program: true, city: 'Dallas')
    @jax = @no_dog_left_behind.pets.create!(name: "Jax", age: 1, breed: 'Golden Retriever', adoptable: true)

  it "shows the applicant and all it's attributes" do

    visit "/applicants/#{@greg.id}"

    expect(page).to have_content(greg.name)
    expect(page).to have_content(greg.street_address)
    expect(page).to have_content(greg.city)
    expect(page).to have_content(greg.state)
    expect(page).to have_content(greg.zipcode)
    expect(page).to have_content(greg.description)
    expect(page).to have_content(greg.status)
  end
end
