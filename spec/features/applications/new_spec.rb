require 'rails_helper'

RSpec.describe 'applications new page' do
  it 'fails to create an incomplete application' do
    visit '/applications/new'

    fill_in 'name', with: 'John'
    fill_in 'address', with: '123 fake street'
    click_button
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Zip code can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
end