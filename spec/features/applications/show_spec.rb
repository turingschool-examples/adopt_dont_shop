require 'rails_helper'

RSpec.describe 'applicant information' do 
  before :each do
    @application = Application.create!(name: 'Murph', street: '123 Apple St', city: 'Boca Raton', state: 'FL', zip: 33498, description: 'I want Jack', status: 'in progress')
    @shelter_1 = Shelter.create!(name: 'Pups and Suds', city: 'Fort Collins', foster_program: false, rank: 2)
    @pet1 = Pet.create!(name: 'Jack', age: 4, breed: 'Australian Shepherd', adoptable: true, shelter_id: @shelter_1.id)
    @pet2 = Pet.create!(name: 'Cooper', age: 3, breed: 'Golden Retriever', adoptable: true, shelter_id: @shelter_1.id)
  end

  it 'displays applicant information' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.status)
  end
end


# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"