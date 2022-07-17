require 'rails_helper'

RSpec.describe 'the admin shelter index' do
  before :each do
    @shelter_1 = Shelter.create!(name: "ABC Shelter", city: "Nashville", foster_program: true, rank: 1)
    @shelter_2 = Shelter.create!(name: "Denver Shelter", city: "Denver", foster_program: true, rank: 2)
    @shelter_3 = Shelter.create!(name: "Franklin Shelter", city: "Franklin", foster_program: false, rank: 9)
    @shelter_4 = Shelter.create!(name: 'Arizona Shelter', city: 'Tuscon', foster_program: true, rank: 4)
  end

  it 'list all shelters in descending alphabetical order' do
    visit "/admin/shelters"

    expect(@shelter_1.name).to appear_before(@shelter_4.name)
    expect(@shelter_4.name).to appear_before(@shelter_2.name)
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(page).to have_content(@shelter_3.name)
 end
end
