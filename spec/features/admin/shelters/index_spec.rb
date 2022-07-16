require 'rails_helper'

RSpec.describe 'admin shelter index page' do
  xit 'displays all shelters in reverse alphabetical order by name' do
    mystery = Shelter.create!(name: 'Mystery Building', city: 'Irvine, CA', foster_program: false, rank: 9)
    aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    hollywood = Shelter.create!(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    rgv = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)

    visit '/admin/shelters'

    expect(page).to have_content(mystery.name)

    within ("#shelter") do
      expect(page.all('.shelters')[0]).to have_content(rgv.name)
      expect(page.all('.shelters')[1]).to have_content(mystery.name)
      expect(page.all('.shelters')[2]).to have_content(hollywood.name)
      expect(page.all('.shelters')[3]).to have_content(aurora.name)
    end
  end

  xit 'has a section for shelters with pending applications' do
    mystery = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    hollywood = Shelter.create!(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    rgv = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"Pending", description:"I love dogs so much and have lots of food for them")
    application_2 = Application.create!(name: "Cindy Smith", street: "727 Lane road", city: "Rockville", state: "CA", zipcode: 95148, status:"Pending", description:"I have a big yard them to run all day")
    application_3 = Application.create!(name: "Ryan Scott", street: "21 Longwalk street", city: "Denver", state: "CO", zipcode: 34687, status:"Pending", description:"I have lots of time to play fetch")
    application_4 = Application.create!(name: "Jean Frisco", street: "546 Uphill Road", city: "Springs", state: "TX", zipcode: 57465, status:"Pending", description:"I will give them all of the pets I can")
    lucille = application_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: mystery.id)
    lobster = application_2.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: aurora.id)
    beethoven = application_3.pets.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: hollywood.id) 
    barey = application_4.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: rgv.id)

    visit '/admin/shelters'

    within "#shelters_pending" do
      expect(page).to have_content(mystery.name)
      expect(page).to have_content(aurora.name)
      expect(page).to have_content(hollywood.name)
      expect(page).to have_content(rgv.name)
    end
  end
end