require 'rails_helper'

RSpec.describe 'the new application page' do
  before :each do
    @shelter = Shelter.create(name: 'Maxfund', city: 'Denver CO', foster_program: false, rank: 9)
    @application_1 = Application.create!(name: "Holden Caulfield", street_address: "123 Main St", city: "New York", state: "NY", zipcode: "12345", description: "I wouldn't be a good pet owner", status: "Pending")
    @pet_1 = Pet.create(adoptable: true, age: 2, breed: 'domestic short hair', name: 'Mundungous', shelter_id: "#{@shelter.id}")
    @pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Captain Pants', shelter_id: "#{@shelter.id}")

    @pet_app = PetApplication.create!(pet: @pet_1, application: @application_1)
    @pet_app_2 = PetApplication.create!(pet: @pet_2, application: @application_1)
  end

  #   As a visitor
  # When I visit the pet index page
  # Then I see a link to "Start an Application"
  # When I click this link
  # Then I am taken to the new application page where I see a form

  it 'shows a new application page with a form' do

    visit "/pets"

    click_link('Start an Application')

    expect(current_path).to be('/applications/new')

  end
  
  it 'allows you to fill in form and submit' do
    visit "/directors/#{@stanley.id}/movies"
    expect(page).to_not have_content("The Shining")

    click_on "Add Movie"

    fill_in(:title, with: "The Shining")
    fill_in(:length, with: 200)
    fill_in(:genre, with: "Horror")
    check('Recently viewed')

    click_button "Create Movie"

    expect(current_path).to eq("/directors/#{@stanley.id}/movies")
    expect(page).to have_content("The Shining")
end



# When I fill in this form with my:
# Name # Street Address # City # State # Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"
