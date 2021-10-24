require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end
  it 'lists all the shelter names' do
    visit "admin/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it 'lists the shelters in reverse alphabetical order' do
    visit "admin/shelters"

    earliest = find("#shelter-#{@shelter_2.id}")
    mid = find("#shelter-#{@shelter_3.id}")
    latest = find("#shelter-#{@shelter_1.id}")

    expect(earliest).to appear_before(mid)
    expect(mid).to appear_before(latest)
  end

  it 'has a section which lists shelters with pending applications' do
    visit "admin/shelters"
    application = Application.create!(
                                      name: "Nate Brown",
                            street_address: "2000 35th Avenue",
                                      city: "Denver",
                                     state: "CO",
                                       zip: "90210",
                                    status: "Pending"
                                        )

    application.pets << @lucille

    expect(page).to have_content("Shelters with Pending Applications")
  end
  end
