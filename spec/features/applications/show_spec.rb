require 'rails_helper'

RSpec.describe 'Application show page' do

  before (:each) do
    @shelter = Shelter.create!(name: "Dumb Friends League", city: "Aurora", foster_program: true, rank: 7)
    @brooke = Application.create!(
            name: "Brooke Hoffmann",
            street_address: "448 N Montgomery St",
            city: "Aurora",
            state: "CO",
            zip_code: 80014,
            description: "I'm an experienced pet owner"
              )
    @rob = Application.create!(
            name: "Rob Griswold",
            street_address: "1234 Dogwood Ct",
            city: "Denver",
            state: "CO",
            zip_code: 80124,
            description: "I love all animals",
            status: "Accepted"
              )
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 5, breed: 'husky', name: 'Zippy', shelter_id: @shelter.id)

    PetApplication.create!(application_id: @brooke.id, pet_id: @pet_1.id)
    PetApplication.create!(application_id: @brooke.id, pet_id: @pet_2.id)
    PetApplication.create!(application_id: @rob.id, pet_id: @pet_3.id)
  end

  it 'can display the attributes of an applicant' do

    visit "/applications/#{@brooke.id}"

    expect(page).to have_content("Name: Brooke Hoffmann")
    expect(page).to have_content("Address: 448 N Montgomery St")
    expect(page).to have_content("Aurora")
    expect(page).to have_content("CO")
    expect(page).to have_content(80014)
    expect(page).to have_content("Applicant description: I'm an experienced pet owner")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content("In Progress")
    expect(page).to_not have_content(@rob.name)
    expect(page).to_not have_content(@rob.street_address)
    expect(page).to_not have_content(@rob.city)
    expect(page).to_not have_content(@rob.zip_code)
    expect(page).to_not have_content(@rob.description)
    expect(page).to_not have_content(@pet_3.name)
    expect(page).to_not have_content("Accepted")
  end
end


# Application Show Page
#
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
