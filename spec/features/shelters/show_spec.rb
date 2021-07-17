require 'rails_helper'

RSpec.describe 'the shelter show' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @shelter_1.pets.create(name: 'garfield', breed: 'shorthair', adoptable: true, age: 1)
  end

  it 'shows the shelter and all its attributes' do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.rank)
    expect(page).to have_content(@shelter_1.city)
  end

  it 'shows the number of pets associated with the shelter' do
    visit "/shelters/#{@shelter_1.id}"

    within '.pet-count' do
      expect(page).to have_content(@shelter_1.pets.count)
    end
  end

  it 'allows the user to delete a shelter' do
    visit "/shelters/#{@shelter_1.id}"

    click_on("Delete #{@shelter_1.name}")

    expect(page).to have_current_path('/shelters')
    expect(page).to_not have_content(@shelter_1.name)
  end

  it 'displays a link to the shelters pets index' do
    shelter_2 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)

    visit "/shelters/#{shelter_2.id}"

    expect(page).to have_link("All pets at #{shelter_2.name}")
    click_link("All pets at #{shelter_2.name}")

    expect(page).to have_current_path("/shelters/#{shelter_2.id}/pets")
  end
end
