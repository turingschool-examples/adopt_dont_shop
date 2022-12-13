require 'rails_helper'

RSpec.describe 'Admin Shelter Show Page' do
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
  end

  it 'shows shelter name and address' do
    visit "/admin/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content("#{@shelter_1.street_address}, #{@shelter_1.city} #{@shelter_1.zip_code}")
  end

  it 'displays average age of all pets under Statistics section' do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Statistics:")
    within('#statistics') do
      expect(page).to have_content("Average age of adoptable pets: 3.5")
    end
  end
end

