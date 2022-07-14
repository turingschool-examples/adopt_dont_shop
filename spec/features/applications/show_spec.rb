require 'rails_helper'

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

RSpec.describe 'the show page' do
  before
  it "has a show page" do
    # shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    # pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    @application_1 = Application.create!(applicant_name: 'Bob Ross', address: '8753 Main St Longmont CO 80765', description: 'I make a lot of money', status: 'rejected')
    @application_2 = Application.create!(applicant_name: 'Meredith Grey', address: '3463 Collin St Denver CO 80035', description: 'I love animals', status: 'accepted')

    visit "/applications"

    expect(page).to have_content(@application_1.applicant_name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    end

  end