require 'rails_helper'

RSpec.describe 'Admin/Shelters/Show page' do
  it 'shows the shelter name and address' do
    shelter1 = Shelter.create!(name: 'New Friends', city: 'Portland, OR', rank: 1, foster_program: true)
    shelter2 = Shelter.create!(name: 'Furbaby For You', city: 'Merrill, OR', rank: 2, foster_program: false)

    visit "/admin/shelters/#{shelter1.id}"

    expect(page).to have_content('New Friends')
    expect(page).to have_content('Portland, OR')
  end
end