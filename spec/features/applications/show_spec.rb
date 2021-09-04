require 'rails_helper'
[ ] done

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
    application = Application.create(name: 'Ted', address: '2335 south Race St., Denver, CO, 80210', description: 'I am awesome' )
    visit "/application"
    # pet = create(:pet)
    # application = create(:application)
    # application_pet = ApplicationPet.create!(pet_id: pet.id, application_id: application.id)

  end
end
