require 'rails_helper'

describe 'application show page' do
#   1. Application Show Page
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  describe 'application details' do
    before(:each) do 
      @application = Application.create!(name: 'John Smith', address: '123 Fake Street', city: 'Springfield', state: 'IL', zipcode: 12345)
      visit "/applications/#{@application.id}"
    end
    
    it 'has the name' do
      expect(page).to have_content("John Smith")
    end
    it 'has the address' do
      expect(page).to have_content("123 Fake Street")
      expect(page).to have_content("Springfield")
      expect(page).to have_content("IL")
      expect(page).to have_content("12345")
    end
    it 'has the description' do
      
    end
    it 'has all pets names' do

    end
    it 'pet names are links'
    it 'has application\'s status'
  end

end