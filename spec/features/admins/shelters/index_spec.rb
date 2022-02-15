require 'rails_helper'

RSpec.describe 'Admin Index page' do
  before :each do
    @dfl = Shelter.create!(foster_program: true, name: "Dumb friends League", city: "Denver", rank: 53)
    @shelter_1 = Shelter.create!(foster_program: true, name: "Dog Only Shelter", city: "Riverside", rank: 27)
    @shelter_2 = Shelter.create!(foster_program: true, name: "Shelter Friends", city: "Springs", rank: 53)
    @shelter_3 = Shelter.create!(foster_program: true, name: "Friends", city: "Springfield", rank: 53)
  end

  it "Shelter Names are listed in Admin Page" do
    visit "/admin/shelters"

    expect(page).to have_content(@dfl.name)
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@dfl.name)
    expect(@dfl.name).to appear_before(@shelter_1.name)

    expect(@shelter_1.name).to_not appear_before(@shelter_2.name)
  end

end
