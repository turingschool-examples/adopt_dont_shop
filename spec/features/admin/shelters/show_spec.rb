require 'rails_helper'

describe 'Admin Shelter Show' do
  before do
    @shelter = Shelter.create(name: "Rescue Shelter", city: "Denver, CO")
    visit "admin/shelters/#{@shelter.id}"
  end

  describe 'display' do
    it 'shelter name and full address' do
      # expect(page).to have_content(@shelter.name)
      # expect(page).to have_content(@shelter.city)
    end
  end
end