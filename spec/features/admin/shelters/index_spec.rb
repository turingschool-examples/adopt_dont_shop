require 'rails_helper'

RSpec.describe 'admin_shelters index page' do
  before :each do
    @shelter_1   = create(:shelter)
    @shelter_2   = create(:shelter)
    @shelter_3   = create(:shelter)
    @shelter_4   = create(:shelter)
    @shelter_5   = create(:shelter)
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