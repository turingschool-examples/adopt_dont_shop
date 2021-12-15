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
    fill_in(:name, with:'Ernest Glover')
    fill_in(:street, with:'5555 W Landsdown Ave')
    fill_in(:city, with:'Phila')
    fill_in(:state, with:'PA')
    fill_in(:zip, with:'19131')

    # require "pry"; binding.pry
    click_button('submit')
    new_app = Application.last

    expect(current_path).to eq("/applications/#{new_app.id}")
  end
end