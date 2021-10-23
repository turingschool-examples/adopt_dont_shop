require 'rails_helper'

RSpec.describe 'application_creation' do
  it 'can create a new application' do
    visit '/applications/new'
    page.fill_in('name', with: 'Joe Smith')
    page.fill_in('street_address', with: '1234 Street Road')
    page.fill_in('city', with: 'Denver')
    page.fill_in('state', with: 'Colorado')
    page.fill_in('zip_code', with: '80222')
    click_button('Save')

    expect(page).to have_content('Joe Smith')
    expect(page).to_not have_content('New Application')
  end
end
