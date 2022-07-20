require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'is able to go admin and list all of the shelters' do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

  visit "/admin/shelters"

  expect(page).to have_content(@shelter_1.name)
  expect(page).to have_content(@shelter_2.name)
  expect(page).to have_content(@shelter_3.name)
  end

  it "is able to show me all pending applicants" do
    applicant = Applicant.create!(name: 'Oliver Smudger',
                                  street_address: '1234 N Random Avenue',
                                  city: 'Tucson',
                                  state: 'Arizona',
                                  zip_code: '12345',
                                  description: 'Text',
                                  application_status: 'In Progress'
                                )
    shelter = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet = applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = applicant.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    visit "/admin/shelters"

    expect(page).to have_content("Fancy pets of Colorado")
  end

  it "is able to show all the shelters with pending app" do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pirate = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @applicant_1 = Applicant.create!(name: 'Oliver Smudger',
                                      street_address: '1234 N Random Avenue',
                                      city: 'Tucson',
                                      state: 'Arizona',
                                      zip_code: '12345',
                                      description: 'I have a big yard and work from home.',
                                      application_status: 'Pending'
                                    )
    ApplicantPet.create!(applicant: @applicant_1,pet: @pirate )
    ApplicantPet.create!(applicant: @applicant_1,pet: @clawdia )

      visit '/admin/shelters'

      within '#pending' do
        expect(page).to have_content('Aurora shelter')
        expect(page).to_not have_content('RGV animal shelter')
      end
  end
end
