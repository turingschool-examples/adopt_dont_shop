require 'rails_helper'

RSpec.describe 'As an admin, when I visit the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application_1 = Application.create!(first_name: "Jon", last_name: "Duttko", str_address: "1018 O St NW", city: "Washington", state: "DC", zip: 20001, home_description: "friendly", status: "Pending")
    @application_1.pets << @shelter_3.pets
  end

  it 'lists all the shelter names in reverse alphabetical order' do
    visit "/admin/shelters/"

    expect("#{@shelter_2.name}").to appear_before("#{@shelter_3.name}", only_text: true)
    expect("#{@shelter_3.name}").to appear_before("#{@shelter_1.name}", only_text: true)
  end

  it 'returns the name of every shelter that has a pending application' do
    visit "/admin/shelters/"
  
      expect(find("div#Pending")).to have_content("#{@shelter_3.name}")
    # end
  end

  it 'has links to the show page for each shelter with pending applcations' do
    visit "/admin/shelters/"
    
    find("div#Pending").click_link("#{@shelter_3.name}")
    expect(current_path).to eq("/admin/shelters/#{@shelter_3.id}")
    
    expect(page).to have_content('Fancy pets of Colorado')
  end
end
