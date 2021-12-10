require 'rails_helper'

RSpec.describe 'Applications Index', type: :feature do
  it 'lists all applicants' do
    derek = Application.create!(name: "Derek", description: "I love dogs", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223 })
    visit '/applications'

    expect(page).to have_content("Applicant: #{derek.name}")

    click_link ("#{derek.name}")

    expect(current_path).to eq("/applications/#{derek.id}")
  end
end
