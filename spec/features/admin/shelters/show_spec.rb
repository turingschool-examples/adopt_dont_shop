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

  it 'shows the average age for pets in section of statistics' do
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

  it 'shows the number of pets in the shelter' do
    shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)
    luna = Pet.create!(name: 'luna', age: 1, breed: 'Cat', adoptable: true, shelter_id: shelter2.id)
    booth = Pet.create!(name: 'booth', age: 11, breed: 'Cat', adoptable: true, shelter_id: shelter2.id)
    archie = Pet.create!(name: 'archie', age: 4, breed: 'Dog', adoptable: true, shelter_id: shelter1.id)
    archie = Pet.create!(name: 'archie', age: 4, breed: 'Dog', adoptable: false, shelter_id: shelter1.id)
    rocky = Pet.create!(name: 'rocky', age: 2, breed: 'Hamster', adoptable: true, shelter_id: shelter1.id)
    opa = Pet.create!(name: 'Opa', age: 2, breed: 'Hamster', adoptable: true, shelter_id: shelter2.id)
    
    visit "/admin/shelters/#{shelter1.id}"
    expect(page).to have_content("Statistics")
    expect(page).to have_content("Adoptable Pet Count: 2")
    
    visit "/admin/shelters/#{shelter2.id}"
    expect(page).to have_content("Statistics")
    expect(page).to have_content("Adoptable Pet Count: 3")
  end
  
  it "has an 'Action Required' section that has pets who have pending applications and have not been approved/rejected" do
    shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 9)
    luna = shelter1.pets.create!(name: 'luna', age: 1, breed: 'Cat', adoptable: true)
    booth = Pet.create!(name: 'booth', age: 11, breed: 'Cat', adoptable: true, shelter_id: shelter1.id)
    application1 = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'Pending'
    )
    application2 = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'In Progress'
    )
    application_pet = ApplicationPet.create!(application_id: application1.id, pet_id: luna.id)
    application_pet = ApplicationPet.create!(application_id: application2.id, pet_id: booth.id, pet_status: "Approved")
    
    visit "/admin/shelters/#{shelter1.id}"
    expect(page).to have_content("Action Required")
    within "#action_required" do
      expect(page).to have_content("luna")
      expect(page).to_not have_content("booth")
    end
  end

  it "has links in 'Action Required' section that go to admin/application/:id" do
    shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 9)
    luna = shelter1.pets.create!(name: 'luna', age: 1, breed: 'Cat', adoptable: true)
    booth = Pet.create!(name: 'booth', age: 11, breed: 'Cat', adoptable: true, shelter_id: shelter1.id)
    application1 = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'Pending'
    )
    application2 = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'In Progress'
    )
    application_pet = ApplicationPet.create!(application_id: application1.id, pet_id: luna.id)
    application_pet = ApplicationPet.create!(application_id: application2.id, pet_id: booth.id, pet_status: "Approved")
    
    visit "/admin/shelters/#{shelter1.id}"
    expect(page).to have_content("Action Required")
    within "#action_required" do
      click_link("luna")
      expect(current_path).to eq("/admin/applications/#{application1.id}")
    end
  end
end
# As a visitor
# When I visit an admin shelter show page
# And I look in the "Action Required" section
# Then next to each pet's name I see a link to the admin application show page where I can accept or reject the pet.