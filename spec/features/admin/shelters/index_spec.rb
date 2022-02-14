require 'rails_helper'

RSpec.describe 'the admin/shelter index' do
  it '/admin/shelters index lists shelters in descending order' do
    shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 9)
    shelter_3 = Shelter.create!(name: 'Maxfund', city: 'Denver, CO', foster_program: true, rank: 9)

    visit "/admin/shelters"

    within('#shelter_name-0') do
      expect(page).to have_content(shelter_3.name)
    end
    within('#shelter_name-1') do
      expect(page).to have_content(shelter_2.name)
    end
    within('#shelter_name-2') do
      expect(page).to have_content(shelter_1.name)
    end
  end
end
