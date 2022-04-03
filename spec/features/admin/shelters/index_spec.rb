require 'rails_helper'

RSpec.describe 'the admin shelter index' do
  it 'list all shelters in descending alphabetical order' do
    @shelter1 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 2)
    @shelter2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter3 = Shelter.create(name: 'Colorado Springs shelter', city: 'Colorado Springs, CO', foster_program: true, rank: 4)
    visit "/admin/shelters"

    page.should have_selector("ul#shelter li:nth-child(1)", text: @shelter1.name)
    page.should have_selector("ul#shelter li:nth-child(2)", text: @shelter3.name)
    page.should have_selector("ul#shelter li:nth-child(3)", text: @shelter2.name)
  end
end
