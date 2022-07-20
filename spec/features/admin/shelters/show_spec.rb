require 'rails_helper'

RSpec.describe 'Admin/Shelters/Show page' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_4 = Shelter.create(name: 'Animal Helpers', city: 'Portland, OR', foster_program: true, rank: 3)

    @pet_1 = Pet.create!(name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: @shelter_2.id)
    @pet_3 = Pet.create!(name: 'Daisy', age: 3, breed: 'cat', adoptable: true, shelter_id: @shelter_3.id)

    @app_1 = Application.create!(name: 'John Doe', street_address: '123 Main St', city: 'New York',
                                 state: 'NY', zipcode: 10_001)
    @app_2 = Application.create!(name: 'Jane Doe', street_address: '456 Main St', city: 'Boston',
                                 state: 'MA', zipcode: 10_002)
    @app_3 = Application.create!(name: 'Mo', street_address: '789 Main St', city: 'Boston',
                                 state: 'MA', zipcode: 10_002)

    @pet_app_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_2.id, status: 'Pending')
    @pet_app_2 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_1.id, status: 'Pending')
    @pet_app_3 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_2.id, status: 'Rejected')
    @pet_app_4 = PetApplication.create!(application_id: @app_3.id, pet_id: @pet_3.id, status: 'Pending')
  end

  it 'shows the shelter name and address' do
    visit "/admin/shelters/#{@shelter_1.id}"

    expect(page).to have_content('Aurora shelter')
    expect(page).to have_content('Aurora, CO')
  end

  it 'does not show info for other shelters' do
    visit "/admin/shelters/#{@shelter_1.id}"

    expect(page).to_not have_content('RGV animal shelter')
    expect(page).to_not have_content('Animal Helpers')
  end

  it 'has a section titled Action Required that lists pets with pending apps (not approved/rejected)' do
    visit "/admin/shelters/#{@shelter_1.id}"

    expect(page).to have_content('Action Required')
    within('#action_required') do
      expect(page).to have_content(@pet_1.name)
    end
  end
  it 'Action Required section has a link to the application page still pending' do
    visit "/admin/shelters/#{@shelter_1.id}"

    expect(page).to have_content('Action Required')
    
    within('#action_required') do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_link("Application ##{@app_2.id} Page")
    end
    click_on "Application ##{@app_2.id} Page"
    expect(current_path).to eq("/admin/applications/#{@app_2.id}")
    expect(page).to have_content(@pet_1.name)
  end
  it 'has a statistics section that shows average age of adoptable pets' do
    pet_6 = @shelter_1.pets.create(name: 'Hooty', age: 6, breed: 'cat', adoptable: true)
    pet_7 = @shelter_1.pets.create(name: 'Blowfish', age: 7, breed: 'cat', adoptable: true)
    pet_8 = @shelter_1.pets.create(name: 'Creedo', age: 8, breed: 'cat', adoptable: true)

    visit "/admin/shelters/#{@shelter_1.id}"
    within('#shelter_statistics') do
      expect(page).to have_content('Average Age of Adoptable Pets: 5.75')
    end
  end
  it 'statistics section has number of adoptable pets at that shelter' do
    pet_6 = @shelter_1.pets.create(name: 'Hooty', age: 6, breed: 'cat', adoptable: true)
    pet_7 = @shelter_1.pets.create(name: 'Blowfish', age: 7, breed: 'cat', adoptable: true)
    pet_8 = @shelter_1.pets.create(name: 'Creedo', age: 8, breed: 'cat', adoptable: true)
    visit "/admin/shelters/#{@shelter_1.id}"
    save_and_open_page
    within('#shelter_statistics') do
      expect(page).to have_content('Adoptable Pets: 4')
    end
  end
end
