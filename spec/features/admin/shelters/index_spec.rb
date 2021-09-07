require "rails_helper"

RSpec.describe 'Admin shelters index' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Atlanta shelter', city: 'Atlanta, GA', foster_program: true, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Charlotte shelter', city: 'Charlotte, NC', foster_program: true, rank: 2)
    @shelter_4 = Shelter.create!(name: 'Seattle shelter', city: 'Seattle, WA', foster_program: true, rank: 8)
  end

  it "lists all the shelters" do
    visit "/admin/shelters"

    save_and_open_page

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
    expect(page).to have_content(@shelter_4.name)
  end
end
