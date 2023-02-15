require 'rails_helper'

RSpec.describe 'the pets index' do
  before(:each) do
    @shelter = create(:shelter)
    @pet_1 = create(:pet, shelter_id: @shelter.id)
    @pet_2 = create(:pet, shelter_id: @shelter.id)
    @pet_3 = create(:pet, name: 'Elle', shelter_id: @shelter.id, adoptable: false)
  end
  it 'lists all the pets with their attributes' do
    visit '/pets'
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.breed)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@shelter.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.breed)
    expect(page).to have_content(@pet_2.age)
    expect(page).to have_content(@shelter.name)
  end

  it 'only lists adoptable pets' do
    visit '/pets'
    expect(page).to_not have_content(@pet_3.name)
  end

  it 'displays a link to edit each pet' do
    visit '/pets'
    expect(page).to have_content("Edit #{@pet_1.name}")
    expect(page).to have_content("Edit #{@pet_2.name}")

    click_link("Edit #{@pet_1.name}")

    expect(page).to have_current_path("/pets/#{@pet_1.id}/edit")
  end

  it 'displays a link to delete each pet' do
    visit '/pets'
    expect(page).to have_content("Delete #{@pet_1.name}")
    expect(page).to have_content("Delete #{@pet_2.name}")

    click_link("Delete #{@pet_1.name}")

    expect(page).to have_current_path('/pets')
    expect(page).to_not have_content(@pet_1.name)
  end

  it 'has a text box to filter results by keyword' do
    visit '/pets'
    expect(page).to have_button('Search')
  end

  it 'lists partial matches as search results' do
    pet_3 = create(:pet, name: 'Elle', shelter_id: @shelter.id)
    pet_4 = create(:pet, name: 'Barney', shelter_id: @shelter.id)
    visit '/pets'

    fill_in 'Search', with: 'Ba'
    click_on('Search')

    expect(page).to have_content(pet_4.name)
    expect(page).to have_content(pet_4.name)
    expect(page).to_not have_content(pet_3.name)
  end

  it 'has a link to start an application' do
    visit '/pets'
    click_link 'Start an Application'

    expect(current_path).to eq('/applications/new')
  end
end
