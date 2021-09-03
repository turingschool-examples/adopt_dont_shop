require 'rails_helper'

RSpec.describe 'application show' do
  before :each do
    @app = Application.create!(name: "Laura", street: "123 This one street", city: "Orlando", state: "FL", zip: 32819, message: "I like pets", status: "Accepted")
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @app.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = @app.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    visit "/application/#{@app.id}"
  end

  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

  it 'displays application info' do
    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.street)
    expect(page).to have_content(@app.city)
    expect(page).to have_content(@app.state)
    expect(page).to have_content(@app.zip)
    expect(page).to have_content(@app.message)
    expect(page).to have_content(@app.status)
  end

  it 'displays links to pets they are applying for' do
    expect(page).to have_link("#{@pet_1.name}")
    expect(page).to have_link("#{@pet_2.name}")
  end
end
