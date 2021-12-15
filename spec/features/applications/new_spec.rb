require 'rails_helper'

# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page

RSpec.describe 'New application page' do
  it 'I see a form' do

    visit '/applications/new'

    fill_in("Name", with:'Ernest Glover')
    fill_in("Street_Address", with:'5555 W Landsdown Ave')
    fill_in("City", with:'Phila')
    fill_in("State", with:'PA')
    fill_in("Zip", with:'19131')
    click_button('submit')

    expect(current_path).to eq("/applications/:id")
  end
end