require 'rails_helper'

RSpec.describe 'index page' do
  it "shows the shelters in alphabetical order" do
    shelter = Shelter.create!(foster_program: true, name: 'Pet Semetary', city: 'Chicago', rank: 8)
    shelter2 = Shelter.create!(foster_program: false, name: 'Boone County', city: 'STL', rank: 2)
    shelter3 = Shelter.create!(foster_program: true, name: 'Turing', city: 'Denver', rank: 5)

    visit "/admin/shelters"

    expect(shelter.name).to appear_before(shelter2.name)
    expect(shelter3.name).to appear_before(shelter.name)
    expect(shelter3.name).to appear_before(shelter2.name)
  end
end
