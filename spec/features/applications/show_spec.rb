require 'rails_helper'

RSpec.describe 'the application show' do
  before :each do
    @application = Application.create(
      name: 'Joseph Puglia',
      street_address: '5201 Whistle St.',
      city: 'Irvine',
      state: 'CA',
      zip_code: '92602'
    )
  end
  it "shows the application and all it's attributes" do
    
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street_address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip_code)
    expect(page).to have_content(@application.description)
    # expect(page).to have_content(@application.pets)
    # expect(page).to have_content(@application.status)
  end

  it 'can shows a form to search for pets by name' do

    visit "/applications/#{@application.id}"

    fill_in('search', with: "Spot")

    click_button 'search'

    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content("Joseph")
  end
end