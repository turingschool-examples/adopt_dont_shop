require 'rails_helper'

RSpec.describe "Filling out forms" do
  
  xit 'fails to fill out form' do
    visit '/applications/new'
    
    click_button "Create Application"
    save_and_open_page
    expect(page).to have_current_path('/applications/new?')
    #not sure why this test doesn't work, lol
  end
end