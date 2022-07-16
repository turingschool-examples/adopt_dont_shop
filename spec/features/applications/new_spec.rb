require 'rails_helper'

RSpec.describe 'application new page' do
  it 'provides an error message if all fields are not filled in' do

    visit "/applications/new"
    expect(current_path).to eq("/applications/new")

    fill_in 'Name', with: 'Jerry'
    click_on('Submit')

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Error:")
  end
end
