require 'rails_helper'

# Application Show Page
#
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

RSpec.describe "the application show" do
  it "can show the applicant information" do
    application = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome' )
    visit "/applications/#{application.id}"
    # pet = create(:pet)
    # application = create(:application)
    # application_pet = ApplicationPet.create!(pet_id: pet.id, application_id: application.id)
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
  end

  it "can display all of the names of the pets that this application is for and links that go to the show page" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome')
    pet = application.pets.create!(adoptable: true, age: 6, breed: 'Golden Retreiver', name: "Dog", shelter_id: shelter.id)
    pet2 = application.pets.create!(adoptable: true, age: 7, breed: 'Siamese', name: "Cat", shelter_id: shelter.id)
    pet3 = application.pets.create!(adoptable: true, age: 8, breed: 'No one knows', name: "Moose", shelter_id: shelter.id )


    visit "/applications/#{application.id}"

    expect(page).to have_link("Dog")
    expect(page).to have_link("Cat")
    expect(page).to have_link("Moose")
  end
end
