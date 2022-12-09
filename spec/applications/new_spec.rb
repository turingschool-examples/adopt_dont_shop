require 'rails_helper'

RSpec.describe 'new application' do
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"

  it 'can fill out a form' do
    visit '/applications/new'

      
  end

end