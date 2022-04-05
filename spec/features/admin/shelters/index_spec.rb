require "rails_helper"

RSpec.describe "admin shelter index" do
  before do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    visit "/admin/shelters"
    @shelters = [@shelter_1, @shelter_2, @shelter_3]
  end

  it 'can return all shelters in reverse alpha order' do
    @shelters.each do |shelter|
    expect(page).to have_content(shelter.name)
    end
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
    expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
  end
end
