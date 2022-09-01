require 'rails_helper'

RSpec.describe 'the applicants show' do
  before :each do
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @applicant = Applicant.create!(first_name: 'John', last_name: 'Dough', street_address: '123 Fake Street', city: 'Denver',
      state: 'CO', zip: 80205, description: "I'm awesome", status: 'pending')
  end

  it "shows the name of the applicant" do
    visit "/applicants/#{@applicant.id}"

    expect(page).to have_content(@applicant.first_name)
    expect(page).to have_content(@applicant.last_name)


  end

  it 'shows the full Address of the Applicant including street address, city, state, and zip code'

  it 'shows the description of why the applicant says they would be a good home for this pets'

  it 'names of all pets that this application is for (all names of pets should be links to their show page)'

  it 'The Applications status, either In Progress, Pending, Accepted, or Rejected'
end
