require 'rails_helper'

RSpec.describe 'admin shelters index', type: :feature do
  
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    
    @application_1 = Application.create!(name: 'John Doe', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love animals!', status: 'Pending')
    @application_2 = Application.create!(name: 'Jane Doe', street_address: '123 South St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love dogs!', status: 'Pending')
    @application_3 = Application.create!(name: 'John Smith', street_address: '123 East St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love cats!', status: 'Pending')
    @application_4 = Application.create!(name: 'Jane Smith', street_address: '123 West St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'I love birds!', status: 'In Progress')

    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_2.id)
    @pet_3 = Pet.create!(adoptable: true, age: 2, breed: 'shorthair', name: 'Clawdia', shelter_id: @shelter_3.id)

    @application_pets_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
    @application_pets_2 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_2.id)
    @application_pets_3 = ApplicationPet.create!(application_id: @application_4.id, pet_id: @pet_3.id)
    
  end

  it 'displays shelters in reverse alphabetical order' do
    visit '/admin/shelters'

    expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
    expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
    expect('Aurora shelter').to_not appear_before('RGV animal shelter')
  end

  it 'displays shelters with pending applications' do
    visit '/admin/shelters'

    within('section#pending') do
      expect(page).to have_content(@shelter_2.name)
      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_3.name)
    end
  end
end