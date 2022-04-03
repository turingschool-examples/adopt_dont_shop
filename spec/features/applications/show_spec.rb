require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    @app1 = Application.create!(name: 'Bobby Smith', address: '3245 E 1st', city: 'Lakewood', state: 'CO', zipcode: '80026', description: 'Im Awesome!', app_status: 'Rejected')
    # require "pry"; binding.pry
    visit "/applications/#{@app1.id}"
  
    # save_and_open_page
    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.state)
    expect(page).to have_content(@app1.zipcode)
    expect(page).to have_content(@app1.description)
    expect(page).to have_content(@app1.app_status)
    expect(page).to have_content("Pets applied for:")
    
    
  end
end 
