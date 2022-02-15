require 'rails_helper'

RSpec.describe 'admin shelter index' do
  it 'displays shelters in the system listed in reverse alphabetical order' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'Peninsula shelter', city: 'San Francisco, CA', foster_program: false, rank: 7)
    shelter_3 = Shelter.create(name: 'Mile High shelter', city: 'Denver, CO', foster_program: false, rank: 8)

    visit "/admin/shelters"

    expect(shelter_2.name).to appear_before(shelter_1.name)
    expect(shelter_2.name).to appear_before(shelter_3.name)
  end
end
