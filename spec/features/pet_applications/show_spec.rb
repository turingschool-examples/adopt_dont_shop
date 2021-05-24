require 'rails_helper'

RSpec.describe 'the application creation' do
  it "shows the pet application and all it's attributes" do
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
    @pet_application = PetApplication.create!(name: 'Kathy', street_address: '16998 Farmwell Drive', city: 'Denver', state: 'Colorado', zip_code: '80014', description: 'No kids', status: 'Pending')
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = @pet_application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = @pet_application.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    # pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pet_applications/#{@pet_application.id}"
    expect(page).to have_content(@pet_application.name)
    expect(page).to have_content(@pet_application.street_address)
    expect(page).to have_content(@pet_application.city)
    expect(page).to have_content(@pet_application.state)
    expect(page).to have_content(@pet_application.zip_code)
    expect(page).to have_content(@pet_application.description)
    expect(page).to have_content(@pet_application.status)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
  end
end
