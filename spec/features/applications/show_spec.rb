require 'rails_helper'

RSpec.describe 'applications show page' do

  # User Story 2
  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:

  # Name of the Applicant
  # Full Address of the Applicant including street address, city, state, and zip code
  # Description of why the applicant says they'd be a good home for this pet(s)
  # names of all pets that this application is for (all names of pets should be links to their show page)
  # The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

  describe 'hen I visit an applications show page' do
    it 'I see Name of the Applicant' do
      applicant = Applicant.create!(name: '', address: '', description: '', pets: '',)
    end
  end
end