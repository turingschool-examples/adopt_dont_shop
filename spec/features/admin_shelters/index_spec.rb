require 'rails_helper'

RSpec.describe "Admin Index" do
  before (:each) do
    @shelter_1 = Shelter.find_or_create_by!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.find_or_create_by!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.find_or_create_by!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  end
  it "displays all Shelters in the system listed in reverse alphabetical order by name" do
    visit 'admin/shelters'

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
    expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
    expect(@shelter_1.name).to_not appear_before(@shelter_2.name)
  end
end
