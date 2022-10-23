require 'rails_helper'

RSpec.describe 'admin shelters index page', type: :feature do
  let!(:garden) {Shelter.create!(name: 'Animal Garden', city: 'Okinawa City', foster_program: false, rank: 7)}
  let!(:mystery) {Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}
  let!(:friends) {Shelter.create!(name: 'Dumb Friends League', city: 'Denver', foster_program: true, rank: 1)}
  let!(:bounce) {Shelter.create!(name: 'Bounce Rescue', city: 'Aurora', foster_program: false, rank: 15)}

  describe 'the admin shelters index page' do
    it 'lists all the shelters in the system in reverse alphabetical order by name' do
      visit '/admin/shelters'
      
      expect(mystery.name).to appear_before(friends.name)
      expect(friends.name).to appear_before(bounce.name)
      expect(bounce.name).to appear_before(garden.name)
    end
  end
end