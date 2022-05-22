require 'rails_helper'

RSpec.describe 'new application' do
  before :each do
    @application = Application.create!(name: "Bob Ross", street_address: "123 Trees St.", city: "Nantuket", state: "MA", zip: "12554")
  end

  it "has a link to start an application" do
    visit '/pets'

    expect(page).to have_link("Start an Application")
    click_link 'Start an Application'
    expect(current_path).to eq('/applications/new')
  end

  it 'can fill the form and submit a new application' do
    visit '/applications/new'

    fill_in "Name", with: "Bob Ross"
    fill_in "Street address", with: "123 Trees St."
    fill_in "City", with: "Nantuket"
    fill_in "State", with: "MA"
    fill_in "Zip", with: "12554"
    click_on "Submit"

    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("Bob Ross")
    expect(page).to have_content("Nantuket")
    expect(page).to have_content("12554")
    expect(page).to have_content("In Progress")
  end

  describe 'form not completed' do
    it 'shows a new form with Errors' do
      visit "/applications/new"

      click_button 'Submit'
      expect(page).to have_current_path("/applications/new")
      expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip can't be blank")
    end
  end
end
