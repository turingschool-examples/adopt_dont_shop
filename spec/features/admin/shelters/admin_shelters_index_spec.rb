require 'rails_helper'

describe 'admin shelters index' do
  before :each do
    @denver = Shelter.create!(name: 'Denver Pet Shelter', city: 'Denver', rank: 1, foster_program: true)
    @greely = Shelter.create!(name: 'Greely Dumb Friends League', city: 'Greelyr', rank: 2, foster_program: true)
    @eagle = Shelter.create!(name: 'Eagle Pet Sanctuary', city: 'Eagle', rank: 3, foster_program: true)
  end

  it 'lists all shelters in reverse alphabetical order' do
    visit 'admin/shelters'
    expect('Greely Dumb Friends League').to appear_before('Eagle Pet Sanctuary')
    expect('Eagle Pet Sanctuary').to appear_before('Denver Pet Shelter')
  end

end