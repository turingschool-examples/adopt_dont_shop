require 'rails_helper'

RSpec.describe 'New Application' do
  it 'can create a new application' do

    visit '/applications/new'

    fill_in('Name', with: "Bob Bobbicus")
    fill_in('Street', with:  "123 Main street")
    fill_in('City', with: "Newtown")
    fill_in('State', with: "State")
    fill_in('Zipcode', with: '80009')
    fill_in('Description', with: 'I love dogs so much and have lots of food for them')

    click_button('Submit')

    expect(page).to have_content("Bob Bobbicus")
  end

  it 'clicking submit on an empty form' do

    visit '/applications/new'

    click_button('Submit')

    expect(page).to have_content("*Fields can not be empty*")
    save_and_open_page
    expect(current_path).to eq('/applications')
  end
end