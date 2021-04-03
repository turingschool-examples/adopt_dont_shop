require 'rails_helper'

RSpec.describe 'the pets index' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = @shelter.pets.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
    visit "/pets"
  end

  it 'lists all the pets with their attributes' do
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
    expect(page).to_not have_content(@pet_3.name)
  end

  it 'displays a link to edit each pet' do
    expect(page).to have_content("Edit #{@pet_1.name}")
    expect(page).to have_content("Edit #{@pet_2.name}")

    click_link("Edit #{@pet_1.name}")

    expect(page).to have_current_path("/pets/#{@pet_1.id}/edit")
  end

  it 'displays a link to delete each pet' do
    expect(page).to have_content("Delete #{@pet_1.name}")
    expect(page).to have_content("Delete #{@pet_2.name}")

    click_link("Delete #{@pet_1.name}")

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(@pet_1.name)
  end

  it 'has a text box to filter results by keyword' do
    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    fill_in 'Search', with: "Ba"
    click_on("Search")

    expect(page).to have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_3.name)
  end

  it 'displays a link to Start and Application' do
    expect(page).to have_content("Start an Application")

    click_link("Start an Application")

    expect(page).to have_current_path("/applications/new")
  end
end
