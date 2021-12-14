require 'rails_helper'

RSpec.describe 'admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)

    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'lists shelter names by name reverse alphabetical order by default' do
    visit "/admin/shelters"

    first = find("#shelter-#{@shelter_2.id}")
    second = find("#shelter-#{@shelter_3.id}")
    third = find("#shelter-#{@shelter_1.id}")

    expect(first).to appear_before(second)
    expect(second).to appear_before(third)
  end

  describe 'pending applications section' do
    it 'has section header' do
      visit "/admin/shelters"

      expect(page).to have_content("Shelters with Pending Applications:")
    end

    it 'lists all shelters with applications that are pending' do
      visit "/admin/shelters"

      expect(page).to_not have_css("#pending#{@shelter_1.id}")

      visit "/pets"
      click_link "Start an Application"

      fill_in 'applicant_name', with: 'Bryan Oleary'
      fill_in 'street_address', with: '1356 west ave'
      fill_in 'city', with: 'Boulder'
      select "Colorado", :from => "state"
      fill_in 'zip_code', with: '13326'

      click_button 'Save'

      fill_in 'pet_name', with: "Clawdia"
      click_button "Search"

      expect(page).to have_content(@pet_2.name)

      within("#search#{@pet_2.id}") do
        expect(page).to have_button('Adopt this Pet')
        click_button "Adopt this Pet"
      end

      expect(page).to have_link("#{@pet_2.name}", href: "/pets/#{@pet_2.id}")

      expect(page).to have_content("Please describe why you would be a good home for these pets.")
      expect(page).to have_field(:description)
      expect(page).to have_button('Submit Application')
      fill_in :description, with: "I'm a good trainer."

      click_button 'Submit Application'

      expect(page).to have_content("Application Status: Pending")
      expect("Pet Name(s):").to appear_before(@pet_2.name, only_text: true)

      visit "/admin/shelters"

      within("#pending#{@shelter_1.id}") do
        expect(page).to have_content("#{@shelter_1.name}")
      end

      pending_shelter = find("#pending#{@shelter_1.id}")

      expect("Shelters with Pending Applications:").to appear_before(pending_shelter)
    end
  end
end
