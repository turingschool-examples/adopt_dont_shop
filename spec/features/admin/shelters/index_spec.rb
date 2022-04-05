require 'rails_helper'

RSpec.describe 'the admin shelter index' do
  it 'list all shelters in descending alphabetical order' do
    @shelter1 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 2)
    @shelter2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter3 = Shelter.create(name: 'Colorado Springs shelter', city: 'Colorado Springs, CO', foster_program: true, rank: 4)
    visit "/admin/shelters"

    page.should have_selector("ul#shelter li:nth-child(1)", text: @shelter1.name)
    page.should have_selector("ul#shelter li:nth-child(2)", text: @shelter3.name)
    page.should have_selector("ul#shelter li:nth-child(3)", text: @shelter2.name)
  end

  it 'list all Shelters with pending applications ' do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    shelter2 = Shelter.create!(foster_program: false, name: 'Portland Shelter', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
    visit "/admin/shelters"
      within("#pending_applications") do
        expect(page).to have_content(shelter.name)
      end
      # page.should have_selector("ul#pending", text: @shelter.name)
  end
end
