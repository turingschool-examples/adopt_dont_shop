require 'rails_helper'

RSpec.describe 'pet application creation' do
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
    @pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Doggo', shelter_id: @shelter.id)
    @pet_5 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Dingo', shelter_id: @shelter.id)
    @pet_6 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Rufus', shelter_id: @shelter.id)
    @pet_7 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Rufus', shelter_id: @shelter.id)
    @pet_8 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Dawg', shelter_id: @shelter.id)
    @pet_9 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Dog', shelter_id: @shelter.id)
  end

  it 'will list pet on application show page after creation' do
    @application = Application.create!(name: 'Jo', address: 'Yus', city: 'No', state: 'MayB', zip: '1234', description: 'Luv dog', status: 'In Progress')
    visit "/applications/#{@application.id}"

    fill_in 'pet_name', with: 'Doggo'
    click_on 'Search'

    expect(page).to have_content("Adopt this pet")

    click_on 'Adopt this pet'

    expect(page).to have_current_path("/applications/#{@application.id}")
    expect(page).to have_link("Doggo")
    expect(page).to have_content("In Progress")
  end
end