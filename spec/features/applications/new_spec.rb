require 'rails_helper'

RSpec.describe 'New application page' do
  it 'links to the new page from the pet index' do
    visit '/pets'

    click_link 'Start an Application'
    expect(current_path).to eq('/applications/new')
  end
  it 'can create a new application' do
    visit '/applications/new'

    fill_in('Name', with: 'Mike Smith')
    fill_in(:street_address, with: '123 Test Street')
    fill_in(:city, with: 'Denver')
    fill_in('State', with: 'CO')
    fill_in(:zipcode, with: 10005)
    fill_in(:description, with: "test description")

    click_button('Submit')

    expect(current_path).to eq("/applications/#{Application.last.id}")
  end

  it "takes the visitor back to the new application page if form fields are incomplete" do
    visit "/applications/new"

    fill_in('Name', with: 'Mike Smith')
    fill_in(:street_address, with: '123 Test Street')
    fill_in(:city, with: 'Denver')
    fill_in('State', with: 'CO')
    fill_in(:description, with: "test description")
    click_button('Submit')

    # expect(current_path).to eq("/applications/new")
    expect(page).to have_content("**Required content missing**")
    expect(page).to have_button('Submit')
    # save_and_open_page
  end
end
