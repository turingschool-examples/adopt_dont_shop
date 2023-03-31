require 'rails_helper'

RSpec.describe "Filling out forms" do
  
  it 'fails to fill out form' do
    visit '/applications/new'
    
    click_button "Create Application"
    
    expect(page).to have_current_path('/applications/new')
    #not sure why this test doesn't work, lol
  end
end