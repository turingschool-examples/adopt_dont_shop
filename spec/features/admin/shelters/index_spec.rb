require 'rails_helper' 

RSpec.describe 'admin shelter index' do

  it 'lists all shelters in reverse alphabetical order' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    visit '/admin/shelters'
    
    expect(shelter2.name).to appear_before(shelter3.name)
    expect(shelter3.name).to appear_before(shelter1.name)
  end

  it 'lists shelters with pending applications' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    app1 = Application.create(name: "Max", street_address: "Made up St", city: "Denver", state: "CO", zip_code: "80000", description: "Love mix breeds. Lots of energy to play with a dog", status: "Pending")
    app2 = Application.create(name: "Alastair", street_address: "Fictional St", city: "Golden", state: "CO", zip_code: "80001", description: "Love big dogs. Great mountain walks on doorstep", status: "Pending")
    pet1 = Pet.create!(name: 'Noodle', age: 2, breed: 'Border Collie', adoptable: true, shelter_id: shelter3.id)
    pet2 = Pet.create!(name: 'Hercules', age: 2, breed: 'American Akita', adoptable: true, shelter_id: shelter1.id)
    pet3 = Pet.create!(name: 'Bumblebee', age: 1, breed: 'Welsh Corgi', adoptable: true, shelter_id: shelter1.id)
    ApplicationPet.create!(application: app1, pet: pet1)
    ApplicationPet.create!(application: app1, pet: pet3)
    ApplicationPet.create!(application: app2, pet: pet2)
    ApplicationPet.create!(application: app2, pet: pet3)

    visit "/admin/shelters"
    
    within("div#pending") do
      expect(page).to have_content("Shelter's with Pending Applications")
      expect(page).to have_content(shelter1.name)
      expect(page).to have_content(shelter3.name)
      expect(page).to_not have_content(shelter2.name)
    end
  end
end
