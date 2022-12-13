require 'rails_helper' 

RSpec.describe 'admin shelter index' do

  it 'lists all shelters in reverse alphabetical order' do
    shelter1 = Shelter.create!(foster_program: true, name: "Doggie Dog World", city: "Denver", rank: 3)
    shelter2 = Shelter.create!(foster_program: true, name: "Endless Pawsabilities", city: "Durango", rank: 1)
    shelter3 = Shelter.create!(foster_program: true, name: "Tail of two Kitties", city: "Seattle", rank: 9)

    visit '/admin/shelters'

    expect(shelter3.name).to appear_before(shelter2.name)
    expect(shelter2.name).to appear_before(shelter1.name)
  end

  it 'contains a section with shelters that have pending applications in alphabetical order' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter_2.pets.create(name: 'Mr. Krabs', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    application1 = pet_1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
    application2 = pet_2.applications.create!(name: 'Jimmy Law', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

    visit "/admin/shelters"

    within("div#pending") do
      expect(page).to have_content("Shelter's with Pending Applications")
      expect('Aurora shelter').to appear_before('RGV animal shelter')
      expect(page).to_not have_content('Fancy pets of Colorado')
    end
  end

  it 'has a link to every shelters show page' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter_2.pets.create(name: 'Mr. Krabs', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    application1 = pet_1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
    application2 = pet_2.applications.create!(name: 'Jimmy Law', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

    visit "/admin/shelters"

    within("div#all") do
      expect(page).to have_link('Aurora shelter', href: "/admin/shelters/#{shelter_1.id}")
      expect(page).to have_link('RGV animal shelter', href: "/admin/shelters/#{shelter_2.id}")
      expect(page).to have_link('Fancy pets of Colorado', href: "/admin/shelters/#{shelter_3.id}")
    end
    
    within("div#pending") do
      expect(page).to have_link('Aurora shelter', href: "/admin/shelters/#{shelter_1.id}")
      expect(page).to have_link('RGV animal shelter', href: "/admin/shelters/#{shelter_2.id}")
    end
  end
end
