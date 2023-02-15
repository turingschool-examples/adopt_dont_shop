require 'rails_helper'

describe 'admin shelter show' do
  before(:each) do
    @shelter1 = Shelter.create!(
      foster_program: true,
      name: 'Alpha house',
      city: 'Springfield',
      rank: 1
    )
    @shelter2 = Shelter.create!(
      foster_program: true,
      name: 'Sigma house',
      city: 'Springfield',
      rank: 3
    )
    @shelter3 = Shelter.create!(
      foster_program: true,
      name: 'Beta house',
      city: 'Springfield',
      rank: 2
    )
    @shelter4 = Shelter.create!(
      foster_program: true,
      name: 'Omega house',
      city: 'Springfield',
      rank: 7
    )
  end
end