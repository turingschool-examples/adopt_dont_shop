# Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe 'the app show' do
  before :each do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    @app = Application.create(name: "John Smith", address: "123 Main St, Denver, CO, 80120", about: "I love a dogs. One please.", status: "Pending")
    ApplicationPet.create!(application_id: @app.id, pet_id: @pet.id)
  end

  it "shows the app and all it's attributes" do
    visit "/applications/#{@app.id}"

    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.address)
    expect(page).to have_content(@app.about)
    expect(page).to have_link(@pet.name)
    expect(page).to have_content(@app.status)
    save_and_open_page
    click_link("#{@pet.name}")
    expect(current_path).to eq("/pets/#{@pet.id}")
  end
end
