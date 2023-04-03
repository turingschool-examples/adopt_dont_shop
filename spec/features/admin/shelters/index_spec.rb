require 'rails_helper'

RSpec.describe "Admin Shelters Index" do
  before :each do
    @aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @mystery_bldg = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @boulder = Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
  end

  it "displays all shelters' names in reverse alphabetical order" do
    visit "/admin/shelters"
save_and_open_page
    expect(@mystery_bldg.name).to appear_before(@boulder.name)
    expect(@boulder.name).to appear_before(@aurora.name)
    expect(@aurora.name).to_not appear_before(@mystery_bldg.name)
  end
end