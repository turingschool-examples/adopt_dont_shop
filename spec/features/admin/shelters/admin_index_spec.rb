require 'rails_helper'

RSpec.describe 'Admin Shelters Index' do
  before :each do
    @craigs = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha, NE", foster_program: true)
    @aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @fontaine = Shelter.create!(name: 'Fontainebleu Institute of Varmint Husbandry', city: 'Golden, CO', foster_program: true, rank: 6)
    @damon = Shelter.create!(name: 'Matt Damon Memorial Rodent Hotel', city: 'Boulder, CO', foster_program: false, rank: 3)
    @beldof = @craigs.apps.create!(
      name: "Gob Beldof",
      address: "12 Aasd",
      city: "Aasdfkj1",
      zip_code: "39533",
      description: "asdfsa",
      status: "Pending",
    )

    @garbo = @aurora.apps.create!(
      name: "Luut Garbo",
      address: "asdf",
      city: "asdfa",
      zip_code: "asdfs",
      description: "asdfaw",
      status: "Pending",
    )

    @smooch = @fontaine.apps.create!(
      name: "Carter Smooch",
      address: " asdgw",
      city: "asdgwe",
      zip_code: "agwef",
      description: "asdhge",
      status: "Pending",
    )

    @laver = @damon.apps.create!(
      name: "Rod Laver",
      address: "asdgwe",
      city: "asd2e",
      zip_code: "ad23dfs",
      description: "asdgsda",
      status: "In Progress",
    )
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

    it 'has a section for Shelters with Pending Applications' do
      expect(page).to have_content("Shelters With Pending Applications")

      within("#pending_apps") do
        expect(page).to have_link(@craigs.name, href: "/admin/shelters/#{@craigs.id}")
        expect(page).to have_link(@aurora.name, href: "/admin/shelters/#{@aurora.id}")
        expect(page).to have_link(@fontaine.name, href: "/admin/shelters/#{@fontaine.id}")
        expect(page).to_not have_link(@damon.name, href: "/admin/shelters/#{@damon.id}")
      end
    end

    it 'lists shelters with pending applications alphabetically' do
      within("#pending_apps") do
        expect(@aurora.name).to appear_before(@craigs.name)
        expect(@craigs.name).to appear_before(@fontaine.name)
      end
    end
  end
end