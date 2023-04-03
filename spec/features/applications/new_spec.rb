require 'rails_helper'

RSpec.describe "Filling out forms" do
  
  it 'fails to fill out form' do
    visit '/applications/new'
    
    click_button "Create Application"
    save_and_open_page
    expect(page).to have_current_path('/applications/new?')
    #I'm validating on backend and front end, but this test still fails.
    #Probably something the way capybara handles the click button request?
  end
end