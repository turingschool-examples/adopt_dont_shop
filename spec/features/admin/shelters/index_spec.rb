require 'rails_helper'

RSpec.describe 'admin index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @mr_pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @app1 = Application.create!(
      name: 'Frank Sinatra',
      street_address: '69 Sinatra Way',
      city: 'Nashville',
      state: 'Tennessee', zip_code: '69420', description: "I've always liked dogs",
      status: 'In Progress'
    )
    @app2 = Application.create!(
      name: 'William Rutherford IV',
      street_address: '420 London Way',
      city: 'Boston',
      state: 'Massachusetts', zip_code: '42069', description: "I think owning a dog would make me appear more normal",
      status: 'In Progress'
    )
  end

  it 'lists the shelters in reverse alphabetical order' do
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it 'has a section which lists the names of shelters with pending applications' do
    PetApplication.create!(pet: @mr_pirate, application: @app1)
    PetApplication.create!(pet: @lucille, application: @app2)
    @app1.update(status: "Pending")
    visit "/admin/shelters"

    expect(page).to have_content("Shelters with Pending Applications:")
    within "#pending" do
    expect("Shelters with Pending Applications:").to appear_before("#{@shelter_1.name}")
    end

    @app2.update(status: "Pending")
    visit "/admin/shelters"

    within "#pending" do
    expect("Shelters with Pending Applications:").to appear_before("#{@shelter_1.name}")
    expect("#{@shelter_1.name}").to appear_before("#{@shelter_3.name}")
    end
  end
end
