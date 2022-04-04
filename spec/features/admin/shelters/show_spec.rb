require 'rails_helper'

RSpec.describe 'the admin shelter show page' do
  it 'shows the shelter name and full address' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)
    
    visit "/admin/shelters/#{shelter1.id}"

    expect(page).to have_content("Aurora shelter")
    expect(page).to have_content("Aurora, CO")
    expect(page).to_not have_content("Denver shelter")
    expect(page).to_not have_content("Denver, CO")
  end
end
