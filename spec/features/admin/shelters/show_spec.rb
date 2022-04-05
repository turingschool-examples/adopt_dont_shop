require 'rails_helper'

RSpec.describe 'the admin shelter show page' do
  it 'shows the shelter name and full address' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)

    visit "/admin/shelters/#{shelter1.id}"

    expect(page).to have_content("Aurora shelter")
    expect(page).to have_content("Aurora, CO")
    expect(page).to_not have_content("Denver shelter")
    expect(page).to_not have_content("Denver, CO")
  end

  xit 'shows the average age for pets in section of statistics' do
    shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)
    luna = Pet.create!(name: 'luna', age: 1, breed: 'Cat', adoptable: true, shelter_id: shelter2.id)
    booth = Pet.create!(name: 'booth', age: 11, breed: 'Cat', adoptable: true, shelter_id: shelter2.id)
    archie = Pet.create!(name: 'archie', age: 4, breed: 'Dog', adoptable: true, shelter_id: shelter1.id)
    rocky = Pet.create!(name: 'rocky', age: 2, breed: 'Hamster', adoptable: true, shelter_id: shelter1.id)

    visit "/admin/shelters/#{shelter1.id}"
    expect(page).to have_content("Statistics")
    expect(page).to have_content("Adoptable Pet Average Age: 3")

    visit "/admin/shelters/#{shelter2.id}"
    expect(page).to have_content("Statistics")
    expect(page).to have_content("Adoptable Pet Average Age: 6")
  end

  it 'shows the average age for pets in section of statistics' do
    shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)
    luna = Pet.create!(name: 'luna', age: 1, breed: 'Cat', adoptable: true, shelter_id: shelter2.id)
    booth = Pet.create!(name: 'booth', age: 11, breed: 'Cat', adoptable: true, shelter_id: shelter2.id)
    archie = Pet.create!(name: 'archie', age: 4, breed: 'Dog', adoptable: true, shelter_id: shelter1.id)
    rocky = Pet.create!(name: 'rocky', age: 2, breed: 'Hamster', adoptable: true, shelter_id: shelter1.id)
    opa = Pet.create!(name: 'Opa', age: 2, breed: 'Hamster', adoptable: true, shelter_id: shelter2.id)

    visit "/admin/shelters/#{shelter1.id}"
    expect(page).to have_content("Statistics")
    expect(page).to have_content("Adoptable Pet Count: 2")

    visit "/admin/shelters/#{shelter2.id}"
    expect(page).to have_content("Statistics")
    expect(page).to have_content("Adoptable Pet Count: 3")
  end
end
