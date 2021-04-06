require 'rails_helper'

RSpec.describe "Owner applications Show Page", type: :feature do
  before(:each) do
    @application1 = OwnerApplication.create!(name: 'Wyatt Wicks', street_address: '559 s. washington st', city: 'Denver', state: 'Colorado', zip_code: 80209)
  end

  it "Goes to an applications show page" do
    visit "/applications/#{@application1.id}"
    expect(page).to have_content('Wyatt Wicks')
    expect(page).to have_content(@application1.street_address)
    expect(page).to have_content(@application1.city)
    expect(page).to have_content(@application1.state)
    expect(page).to have_content(@application1.zip_code)
  end
end
