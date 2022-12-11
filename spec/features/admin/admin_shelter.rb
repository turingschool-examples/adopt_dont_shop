require 'rails_helper'

RSpec.describe "admin" do
  it 'displays shelters in reverse alphabetical order' do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_3 = Shelter.create(name: 'Zoulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    
    visit '/admin/shelters'
    save_and_open_page
    expect(@shelter_3.name).to appear_before(@shelter.name)
  end
end