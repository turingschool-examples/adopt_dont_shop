require 'rails_helper'

RSpec.describe 'admin index page' do
  it 'lists all shelters in reverse alpabetic order' do
    shelter_1 = Shelter.create!(name: 'Durango shelter', city: 'Durango, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create!(name: 'Athens Area Humane', city: 'Athens, GA', foster_program: true, rank: 7)
    shelter_3 = Shelter.create!(name: 'Bend City Shelter', city: 'Bend, OR', foster_program: true, rank: 8)
    shelter_4 = Shelter.create!(name: 'Cats and Dogs of Chicago', city: 'Chicago, IL', foster_program: false, rank: 3)
    shelter_5 = Shelter.create!(name: 'San Fran Loves Corgies', city: 'San Francisco, CA', foster_program: false, rank: 5)

    visit '/admin/shelters'

    expect(shelter_5.name).to appear_before(shelter_2.name)

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
    expect(page).to have_content(shelter_4.name)
    expect(page).to have_content(shelter_5.name)
  end
end