require 'rails_helper'

RSpec.describe 'AdminShelters Index' do
  describe 'As an admin when I visit the Index page' do
    before(:each) do 
      @pound = Shelter.create!(foster_program: true, name: 'The Pound', city: "Denver", rank: 1)
      @humaine = Shelter.create!(foster_program: true, name: 'Humaine Society', city: "Boulder", rank: 1)
    end
    it 'I should see' do 
      visit '/admin/shelters'

      expect(@pound.name).to appear_before @humaine.name
      
    end
  end
end