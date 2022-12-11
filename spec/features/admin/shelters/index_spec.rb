require 'rails_helper'

RSpec.describe 'admin_shelters index page' do
  before :each do
    @barky   = Shelter.create!(foster_program: true, name: "Barky Bark's", city: "New York City", rank: 58)
    @big   = Shelter.create!(foster_program: true, name: "Big Boi Bud's", city: "Highland", rank: 56)
    @meow   = Shelter.create!(foster_program: false, name: "Meowin' Right", city: "Denver", rank: 47)
    @stanky   = Shelter.create!(foster_program: true, name: "Stank Town", city: "Redlands", rank: 23)
    @rofl   = Shelter.create!(foster_program: true, name: "ROFL Rescue", city: "Denver", rank: 1)
  end

  it 'displays the name of all the shelters' do
    visit "/admin/shelters"

    expect(page).to have_content(@barky.name)
    expect(page).to have_content(@big.name)
    expect(page).to have_content(@meow.name)
    expect(page).to have_content(@stanky.name)
    expect(page).to have_content(@rofl.name)
  end

  it 'displays the name of all the shelters in reverse alphabetical order' do
    visit "/admin/shelters"

    expect(@stanky.name).to appear_before(@rofl.name)
    expect(@rofl.name).to appear_before(@meow.name)
    expect(@meow.name).to appear_before(@big.name)
    expect(@big.name).to appear_before(@barky.name)
  end

  it 'has a section where shelters that have pending applications appear' do
    visit "/admin/shelters"

    expect(page).to have_content("Shelters With Pending Applications")
  end
end