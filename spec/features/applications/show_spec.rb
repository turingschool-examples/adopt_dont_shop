require 'rails_helper'

RSpec.describe 'the application show page' do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.rank)
    expect(page).to have_content(shelter.city)
  end
end
