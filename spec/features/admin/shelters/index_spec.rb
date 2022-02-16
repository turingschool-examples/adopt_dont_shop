require 'rails_helper'

RSpec.describe 'Index Page' do
  it 'alphabetizes shelters in descending order' do
    club_cuddles = Shelter.create!(name: "Club Cuddles", city: "Colorado Springs", rank: 2, foster_program: true)
    homing_homies = Shelter.create!(name: "Homing Homies", city: "Houston", rank: 1, foster_program: true)

    visit "/admin/shelters"

    expect(homing_homies.name).to appear_before(club_cuddles.name)
  end
end