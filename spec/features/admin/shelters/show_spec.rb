require 'rails_helper'

RSpec.describe 'admin shelter show page' do
  before (:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end

  it 'has the shelters name and location' do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.city)
    expect(page).not_to have_content(@shelter_1.rank)
    expect(page).not_to have_content(@shelter_1.foster_program)
  end
end
