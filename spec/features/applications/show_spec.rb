require 'rails_helper'

RSpec.describe 'application show' do
  it "shows the application and all it's attributes" do
    murph = Application.create!(name: "Murph", street_address: "456 Acres Ln", city: "Boca Rotan", state: "FL", zip_code: "33481", description: "Jack would have a brother", status: "In Progress")
    cyle = Application.create!(name: "Cyle", street_address: "139 Corvette St", city: "Inman", state: "SC", zip_code: "29349", description: "I would take him disc'n", status: "In Progress")
    
    visit "/applications/#{murph.id}"

    expect(page).to have_content(murph.name)
    expect(page).to have_content(murph.street_address)
    expect(page).to have_content("In Progress")
    expect(page).to_not have_content(cyle.name)
  end
end
