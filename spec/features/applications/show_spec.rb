require 'rails_helper'

RSpec.describe 'the application show' do
  before :each do 
    @app_1 = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "I'm ready to love again" )
  end
  it "shows the application and all its attributes" do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_1.street_address)
    expect(page).to have_content(@app_1.city)
    expect(page).to have_content(@app_1.state)
    expect(page).to have_content(@app_1.zip_code)
    expect(page).to have_content(@app_1.description)
    expect(page).to have_content(@app_1.status)
  end

  it 'has text box to search for pet by name' do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_button("Search")
  end
end

