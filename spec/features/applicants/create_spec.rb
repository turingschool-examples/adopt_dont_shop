require 'rails_helper'

RSpec.describe 'New applicant' do
  before (:each) do
    @greg = Applicant.create!(name: 'Greg Flaherty', street_address: '123 MyStreet St.', city: "Dallas", state: "TX", zipcode: '12345', description: "Love dogs", status: "In progress")
    @no_dog_left_behind = Shelter.create!(name: 'No Dog Left Behind', rank: 1, foster_program: true, city: 'Dallas')
    @jax = @no_dog_left_behind.pets.create!(name: "Jax", age: 1, breed: 'Golden Retriever', adoptable: true)

  it "starts an application from pet index page" do

    visit "/pets/"

    expect(page).to have_link("Start an Application")
  end

  it "clicking on link takes you to new application" do

    visit "/pets/"

    click_on "Start an Application"
    expect(current_path).to eq("applicants/new")
    expect(page).to have_field('#name')
    expect(page).to have_field('#street_address')
    expect(page).to have_field('#city')
    expect(page).to have_field('#state')
    expect(page).to have_field('#zipcode')
    expect(page).to have_field('#description')
  end
end
