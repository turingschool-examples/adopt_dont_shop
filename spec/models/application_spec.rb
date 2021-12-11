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


RSpec.describe Application do
  describe 'relationship' do
    it { should have_many(:pet_applications) }

    it { should have_many(:pets).through(:pet_applications) }

  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

end
