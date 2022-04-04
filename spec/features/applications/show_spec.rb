require 'rails_helper'
# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

RSpec.describe 'the applications show page' do
  before do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)

    @application = Application.create(
      name: 'Sherman',
      address: '123 Main St', city: 'Longmont', state: 'CO', zipcode: '80501',
      description: 'Loves animals',
      status: 'Accepted'
    )
    PetApplication.create!(pet_id: @pet_1.id, application_id: @application.id)
    PetApplication.create!(pet_id: @pet_2.id, application_id: @application.id)

    visit "/applications/#{@application.id}"
  end

  it 'shows the attributes of the application' do
    save_and_open_page
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zipcode)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.status)
  end

  it 'pet names has redirect link' do
    expect(page).to have_link(@pet_1.name.to_s, href: "/pets/#{@pet_1.id}")
    click_link @pet_1.name.to_s

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end
end
