require 'rails_helper'

RSpec.describe 'the admin_shelter index' do
  let!(:admin){Admin.create!()}
  let!(:shelter_1){Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let!(:shelter_2){Shelter.create!(name: 'Lakewood shelter', city: 'Lakewood, CO', foster_program: false, rank: 6)}

  it 'lists all the shelters in reverse alphabetical order' do
    visit '/admin/shelters'

    expect("Lakewood shelter").to appear_before("Aurora shelter")
  end
end
