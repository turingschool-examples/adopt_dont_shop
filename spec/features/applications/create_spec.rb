require 'rails_helper'

RSpec.describe 'creating an application' do
  before (:each) do
    visit "/pets"
  end

  it 'can submit a comlpete form' do
    click_link 'Start an Application'

    fill_in :name, with: "Billy Swanson"
    fill_in :street_address, with: "123 Main Lane"
    fill_in :city, with: "Atlanta"
    fill_in :state, with: "Florida"
    fill_in :zip_code, with: "80808"
    click_button 'Submit'

    application = Application.all.first

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content("Status: In Progress")
    expect(page).to have_content("Description:")
  end

  it 'shows an error if you submit an incomplete form' do
    click_link 'Start an Application'

    fill_in :name, with: "Billy Swanson"
    click_button "Submit"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Error: Street address can't be blank")
    expect(page).to have_content("Error: City can't be blank")
    expect(page).to have_content("Error: State can't be blank")
    expect(page).to have_content("Error: Zip code can't be blank")
  end
end
