require 'rails_helper'

RSpec.describe 'admin shelter show page' do
  before :each do
    shelter = Shelter.create!(name: 'Snoops Dogs', city: 'Compton', rank: 1, foster_program: true)

  end


end