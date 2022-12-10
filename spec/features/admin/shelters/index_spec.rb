require 'rails_helper'

RSpec.describe 'admin_shelters index page' do
  before :each do
    @shelter_1   = Shelter.create!(foster_program: true, name: "Barky Bark's", city: "New York City", rank: 58)
    @shelter_2   = Shelter.create!(foster_program: true, name: "Big Boi Bud's", city: "Highland", rank: 56)
    @shelter_3   = Shelter.create!(foster_program: false, name: "Meowin' Right", city: "Denver", rank: 47)
    @shelter_4   = Shelter.create!(foster_program: true, name: "Stank Town", city: "Redlands", rank: 23)
    @shelter_5   = Shelter.create!(foster_program: true, name: "ROFL Rescue", city: "Denver", rank: 1)
  end

  it 'displays the name of all the shelters' do
    visit "/admin/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
    expect(page).to have_content(@shelter_4.name)
    expect(page).to have_content(@shelter_5.name)
  end

  it 'displays the name of all the shelters in reverse alphabetical order' do
    visit "/admin/shelters"

    expect(@shelter_1.name).to appear_before(@shelter_2.name)
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_4.name)
    expect(@shelter_4.name).to appear_before(@shelter_5.name)
  end
end