require 'rails_helper'

RSpec.describe Application, type: :feature do
  it 'has a form that intakes all params' do
    
    
    
    
    
    
    
    
    visit '/applications/new'
    fill_in 'name', with: 'Joann Smith'
    fill_in 'street_address', with: '111 Street Name'
    fill_in 'city', with: 'Denver'
    fill_in 'state', with: 'CO'
    fill_in 'zipcode', with: '00012'
    fill_in 'description', with: "I'm a great person"
    click_on 'Submit'
    expect(current_path).to eq("/applications")
    
  end
end