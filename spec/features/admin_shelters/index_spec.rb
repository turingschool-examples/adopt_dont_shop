require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_4 = Shelter.create(name: 'Fake', city: 'Denver, CO', foster_program: true, rank: 15)

    @app_1 = Application.create(name: 'Caroline Tan', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'pending', description: 'kind')
    @app_2 = Application.create(name: 'Ezze Alwfai', street: '1234 fake st', city: 'Lafayette', state: 'Colorado', zip_code: 80328, application_status: 'pending', description: 'rich')
    @app_3 = Application.create(name: 'Marla Shulz', street: '2020 Corona st', city: 'Denver', state: 'Colorado', zip_code: 80218, application_status: 'pending', description: 'safe')
    @app_4 = Application.create(name: 'No pets', street: '20 Gath st', city: 'Marco', state: 'Florida', zip_code: 34145, application_status: 'in progress', description: 'safe')

    @app_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: @shelter_1.id)
    @app_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_1.id)
    @app_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: @shelter_2.id)
    @app_3.pets.create(name: 'Toby', breed: 'golden', age: 1, adoptable: true, shelter_id: @shelter_3.id)
    visit "/admin/shelters"
  end

  it 'lists all the shelter names' do
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it 'lists all the shelters in reverse alphabetical order' do
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it 'has a section for shelters with pending applications' do
    within('section#pending') do
      expect(page).to have_content("#{@shelter_1.name}")
      expect(page).to have_content("#{@shelter_2.name}")
      expect(page).to have_content("#{@shelter_3.name}")
    end
  end

  it 'does not display shelters without pending applications' do
    within('section#pending') do
      expect(page).to_not have_content("#{@shelter_4.name} pending applications")
    end
  end


  it 'has a pending applications section that are alphabetized' do
    within('section#pending') do
      expect(@shelter_1.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_2.name)
    end
  end


end
