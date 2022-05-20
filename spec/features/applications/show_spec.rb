require 'rails_helper'

# TODO: merge seeds files to make objects in tests consistent

RSpec.describe 'the shelter show' do
  let(:application) { Application.create!(name: 'Debbie', street_address: '1234 dog way', city: "San Francisco", state: 'CA', zip_code: 66012, description: 'I love dogs', pet_names: 'Pickle, Brownie', application_status: 'Accepted') }

  it "shows an application and all it's attributes" do
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.pet_names)
    expect(page).to have_content(application.application_status)
  end
end
