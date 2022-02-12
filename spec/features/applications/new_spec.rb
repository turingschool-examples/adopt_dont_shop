require 'rails_helper'

RSpec.describe "Starting an Application" do
  it "displays form for user to fill out and redirects to show page" do
    visit '/application/new'
    fill_in 'Name:', with: 'Jerry'
    fill_in 'Street Address:', with: '15 Glen Street'
    fill_in 'City:', with: 'Los Angeles'
    fill_in 'State:', with: 'CA'
    fill_in 'Zip Code:', with: 34567
    fill_in 'Zip Code:', with: 34567
    click_on('Save')
    application = Application.first
    expect(current_path).to eq("/application/#{application.id}")
    expect(page).to have_content("In Progress")
  end
end
