require 'rails_helper'

RSpec.describe 'applications view' do
  before(:each) do
    @application_1 = Application.create!(
      name: "John", 
      street_address: "936 Akin", 
      city: "Fort Collins", 
      state: "CO.", 
      zip_code: 80521, 
      description: "Boston Terrier", 
      status: "Pending")
  end

  it 'can show the application attributes in a form' do 
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
  end
end