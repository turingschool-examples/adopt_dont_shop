require 'rails_helper'

RSpec.describe 'the application show' do
  before(:each) do 
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter.id)
    @application_1 = @pet_1.applications.create(
      name: "Billy Mays",
      street_address:  "123 Main St",
      city: "Aurora",
      state: "CO",
      zip: "80012",
      status: "",
      description: "I like pets",
      status: "In Progress"
  )
  @application_2 = @pet_2.applications.create(
    name: "Gwen Stefani",
    street_address:  "125 Main St",
    city: "Aurora",
    state: "CO",
    zip: "80012",
    status: "",
    description: "I like pets even more",
    status: "Pending"
  )
end
  it 'shows the name, description, pets, app status' do
    visit "/applications/#{@application_1.id}"
    
    expect(page).to have_content("#{@application_1.name}")
    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@application_1.status}")
  end

  it 'shows address' do
    visit "/applications/#{@application_1.id}"
    save_and_open_page

    expect(page).to have_content("#{@application_1.street_address}, #{@application_1.city} #{@application_1.state} #{@application_1.zip}")
  end

  it 'links to pet page' do
    visit "/applications/#{@application_1.id}"

    click_link("#{@pet_1.name}")
    save_and_open_page
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end
end

# 1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"