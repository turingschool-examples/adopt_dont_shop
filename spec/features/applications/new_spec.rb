require 'rails_helper'

RSpec.describe 'New page' do
  it "shows an error when a user does not fill out a field" do
    visit '/applications/new'

    fill_in 'Name', with: ''

    click_on 'Submit'

    expect(page).to have_content("Error: Name can't be blank")
    expect(current_path).to eq('/applications/new')
  end
end
