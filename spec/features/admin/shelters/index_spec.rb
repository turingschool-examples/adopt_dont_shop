require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application1 = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "In Progress")
    @application2 = Application.create!(first_name: "Peter", last_name: "Pinckens", street_address: "123 Pineapple Street", city: "Denver", state: "CO", zip_code: 72641, description: "I would really like an animal to keep me company", status: "In Progress")
    @application3 = Application.create!(first_name: "Molly", last_name: "Johnson", street_address: "123 Stuart Street", city: "Baton Rouge", state: "CO", zip_code: 88263, description: "I would really like a dog!", status: "In Progress")
  end

  it 'lists all the shelters in reverse alphabetical order' do
    visit "/admin/shelters"

    this = "RGV animal shelter"
    that = "Fancy pets of Colorado"

    expect(this).to appear_before(that)
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

    it 'I see the name of one shelter that has a pending application' do
      visit "/applications/#{@application1.id}"
      fill_in('Search for pet by name:', with: 'Mr. Pirate')
      click_on('Search for Pet')
      within("#pet_#{@pet1.id}") do
        click_button("Adopt this Pet")
      end

      fill_in('Please describe why you would like to adopt these pets.', with: 'I think I would make a great pet owner.')
      click_on('Submit My Application')

      visit "/admin/shelters"

      within("#pending_shelters") do
        expect(page).to have_content('Aurora shelter')
        expect(page).to_not have_content('Fancy pets of Colorado')
      end
    end

    it 'I see the name of every shelter that has a pending application' do
      visit "/applications/#{@application1.id}"
      fill_in('Search for pet by name:', with: 'Mr. Pirate')
      click_on('Search for Pet')
      within("#pet_#{@pet1.id}") do
        click_button("Adopt this Pet")
      end
  
      fill_in('Please describe why you would like to adopt these pets.', with: 'I think I would make a great pet owner.')
      click_on('Submit My Application')

      visit "/applications/#{@application2.id}"
      fill_in('Search for pet by name:', with: 'Clawdia')
      click_on('Search for Pet')
      within("#pet_#{@pet2.id}") do
        click_button("Adopt this Pet")
      end
  
      fill_in('Please describe why you would like to adopt these pets.', with: 'I would love this animal!')
      click_on('Submit My Application')\

      visit "/applications/#{@application3.id}"
      fill_in('Search for pet by name:', with: 'Lucille Bald')
      click_on('Search for Pet')
      within("#pet_#{@pet3.id}") do
        click_button("Adopt this Pet")
      end
  
      fill_in('Please describe why you would like to adopt these pets.', with: 'Please give me this pet!')
      click_on('Submit My Application')

      visit "/admin/shelters"
  
      within("#pending_shelters") do
        expect(page).to have_content('Aurora shelter')
        expect(page).to_not have_content('RGV animal shelter')
        expect(page).to have_content('Fancy pets of Colorado')
      end
    end

end
