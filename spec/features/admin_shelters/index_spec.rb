require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application = Application.create({
                                        name: 'Jeff',
                                        street_address: '123 Main Street',
                                        city: 'Denver',
                                        state: 'CO',
                                        zip_code: 22_314,
                                        reason: 'Nice person'
                                      })

    @pet_4 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter_1.id)
    @pet_5 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter_1.id)

    @pet_6 = @application.pets.create(adoptable: true, age: 4, breed: 'sharpe', name: 'Diogee',
                                      shelter_id: @shelter_2.id)
    @pet_7 = @application.pets.create(adoptable: true, age: 4, breed: 'poodle', name: 'Cosmo',
                                      shelter_id: @shelter_3.id)
  end

  it 'as an admin, shelters are listed in reverse alphabetical order by name' do
    visit '/admin/shelters'
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it 'displays list of shelters with pending applications' do
    visit '/admin/shelters'
    expect(page).to have_content('Shelters with Pending Applications:')
    within('#pending') do
      expect(page).to have_content(@shelter_1.name)
    end
  end

  it 'displays list of shelters with pending applications in alphabetical order' do
    visit '/admin/shelters'
    expect(page).to have_content('Shelters with Pending Applications:')
    within('#pending') do
      expect(@shelter_1.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_2.name)
    end
  end

  it 'displays list of shelters with each one linking to that shelters show page' do 
    visit '/admin/shelters'
    click_link(@shelter_1.name)
    expect(current_path).to eq("/admin/shelters/#{@shelter_1.id}")
    visit '/admin/shelters'
    click_link(@shelter_2.name)
    expect(current_path).to eq("/admin/shelters/#{@shelter_2.id}")
  end
end
