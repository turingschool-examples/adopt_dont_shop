require 'rails_helper'

RSpec.describe 'Admin Shelters Index' do
  before :each do
    @craigs = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha, NE", foster_program: true)
    @aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @fontaine = Shelter.create!(name: 'Fontainebleu Institute of Varmint Husbandry', city: 'Golden, CO', foster_program: true, rank: 6)
    @damon = Shelter.create!(name: 'Matt Damon Memorial Rodent Hotel', city: 'Boulder, CO', foster_program: false, rank: 3)
    @shelters = [@craigs, @aurora, @fontaine, @damon]
    visit "/admin/shelters"
  end

  describe 'as a visitor when I visit the admin shelter index' do
    it 'lists all shelters in the system' do
      @shelters.each do |shelter|
        expect(page).to have_content(shelter.name)
      end
    end

    it 'lists them in reverse alphabetical order by name' do
      expect(@damon.name).to appear_before(@fontaine.name)
      expect(@fontaine.name).to appear_before(@craigs.name)
      expect(@craigs.name).to appear_before(@aurora.name)
    end
  end
end