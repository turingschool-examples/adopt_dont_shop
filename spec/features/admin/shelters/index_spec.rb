require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  it 'lists all the shelters in reverse alphabetical order by name' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)
    shelter3 = Shelter.create(name: 'Arvada shelter', city: 'Arvada, CO', foster_program: false, rank: 7)
    
    visit '/admin/shelters'

    expect(shelter2.name).to appear_before(shelter1.name)
    expect(shelter1.name).to appear_before(shelter3.name)
  end
  
  it 'lists all the shelters with pending applications' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter1.id)
    application = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'Pending',
    )
    application_pet = ApplicationPet.create(pet_id: pet_1.id, application_id: application.id)
    
    visit '/admin/shelters'

    within "Shelters with Pending Applications" do
      expect(page).to have_content('Aurora shelter')
      expect(page).to_not have_content('Denver shelter')
    end
  end


end
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelter's with Pending Applications"
# And in this section I see the name of every shelter that has a pending application