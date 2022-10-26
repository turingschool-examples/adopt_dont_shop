require 'rails_helper'

RSpec.describe 'admin index page' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Durango shelter', city: 'Durango, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Athens Area Humane', city: 'Athens, GA', foster_program: true, rank: 7)
    @shelter_3 = Shelter.create!(name: 'Bend City Shelter', city: 'Bend, OR', foster_program: true, rank: 8)
    @shelter_4 = Shelter.create!(name: 'Cats and Dogs of Chicago', city: 'Chicago, IL', foster_program: false, rank: 3)
    @shelter_5 = Shelter.create!(name: 'San Fran Loves Corgies', city: 'San Francisco, CA', foster_program: false, rank: 5)

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_2.id)
    @pet_3 = Pet.create(adoptable: false, age: 8, breed: 'mix', name: 'Kumquat', shelter_id: @shelter_3.id)
    @pet_4 = Pet.create(adoptable: true, age: 8, breed: 'calico', name: 'Donuts', shelter_id: @shelter_3.id)
    @pet_5 = Pet.create(adoptable: false, age: 8, breed: 'corgie', name: 'Squeeker', shelter_id: @shelter_4.id)

    @application_1 = Application.create!(name: 'Pam Pulzone', street_address: '66225 Wallace Rd', city: 'Bend', state: 'OR', zip: 97702, description: 'Fenced yard, loving home', status: 'Pending')
    @application_2 = Application.create!(name: 'Dan Boston', street_address: '774 Boone Rd', city: 'Greenville', state: 'SC', zip: 56843, description: 'Experience with difficult dogs', status:  'Pending')

    @application_pet_1 = ApplicationPet.create!(application: @application_1, pet: @pet_1)
    @application_pet_2 = ApplicationPet.create!(application: @application_2, pet: @pet_3)
  end
  
  it 'lists all shelters in reverse alphabetic order' do
    visit '/admin/shelters'

    expect(@shelter_5.name).to appear_before(@shelter_2.name)

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
    expect(page).to have_content(@shelter_4.name)
    expect(page).to have_content(@shelter_5.name)
  end

  it 'has a section for shelters with pending applications' do
    visit '/admin/shelters'

    within("#shelter") do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_3.name)
    end
  end
end