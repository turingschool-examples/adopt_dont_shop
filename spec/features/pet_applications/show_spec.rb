require 'rails_helper'

RSpec.describe "the pet application show page" do
  it "shows the application and all its attributes" do
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application = Application.create!(name: 'Alice Pieszecki', street: '407 Race St', city: 'Denver', state: 'CO', zip_code: 80305, status: 'pending')
  end
end

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
