require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @mr_pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille_blad = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @nimbus = @shelter_2.pets.create(name: 'Nimbus', breed: 'corgi', age: 1, adoptable: true)
  end

  it 'lists all the shelter names' do
    visit "/admin/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it 'lists the shelters by reverse abc order by name' do
    visit "/admin/shelters"
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it 'has a section for Shelters with Pending Applications' do
    application = Application.create!(status: "Pending", name: "Bob Bingus", street: '123 Main',city: 'Leadville', state: 'CO',
    zip: 11111, description: "I'm a good dude")
    ApplicationPet.create!(pet_id: "#{@mr_pirate.id}", application_id: "#{application.id}")

    visit "/admin/shelters"
    expect(page).to have_content("Shelters with Pending Applications")
    within('#pending') do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_no_content(@shelter_3.name)
    end
  end

  it "links to a shelter's show page" do
    visit "/admin/shelters"

    click_on "#{@shelter_1.name}"

    expect(current_path).to eq("/admin/shelters/#{@shelter_1.id}")
  end

  it "shows the shelters with pending applications in alpha order" do
    application1 = Application.create!(status: "Pending", name: "Bob Bingus", street: '123 Main',city: 'Leadville', state: 'CO',
    zip: 11111, description: "I'm a good dude")
    application2 = Application.create!(status: "Pending", name: "Clark Kent", street: '123 Main St', city: 'Leadville', state: 'CO',
    zip: 11111, description: "I'm married to a good dude")
    application3 = Application.create!(status: "Pending", name: "Susan Strong", street: '123 Main St', city: 'Pleasantville', state: 'ME',
    zip: 11111, description: "Susan strong")
    ApplicationPet.create!(pet_id: "#{@mr_pirate.id}", application_id: "#{application2.id}")
    ApplicationPet.create!(pet_id: "#{@lucille_blad.id}", application_id: "#{application1.id}")
    ApplicationPet.create!(pet_id: "#{@nimbus.id}", application_id: "#{application3.id}")

    visit "/admin/shelters"

    within("#pending") do
      expect(@shelter_1.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_2.name)
    end
  end

end
