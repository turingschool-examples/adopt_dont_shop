require 'rails_helper'

RSpec.describe 'Pet Index' do
  it 'lists all the pets with their attributes' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.breed)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(shelter.name)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(shelter.name)
  end

  it 'only lists adoptable pets' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    visit "/pets"

    expect(page).to_not have_content(pet_3.name)
  end

  it 'displays a link to edit each pet' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_content("Edit #{pet_1.name}")
    expect(page).to have_content("Edit #{pet_2.name}")

    click_link("Edit #{pet_1.name}")

    expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
  end

  it 'displays a link to delete each pet' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_button("Delete #{pet_1.name}")
    expect(page).to have_button("Delete #{pet_2.name}")

    click_button("Delete #{pet_1.name}")

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(pet_1.name)
  end

  it 'displays a link to start an application for a pet' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_content("Start an Application")
    click_link("Start an Application")

    expect(current_path).to eq("/applications/new")
  end

  it 'has a text box to filter results by keyword' do
    visit "/pets"
    expect(page).to have_button("Search")
  end


  it 'list matches to names containing entry and case insensitive' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Babe', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Babeee', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'dog', name: 'Elle', shelter_id: shelter.id)

    visit "/pets"
    fill_in 'Search by name', with: "babe"
    click_on("Search")

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)

  end

  it 'list matches to pet breed' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'dog', name: 'Elle', shelter_id: shelter.id)

    visit "/pets"
    fill_in 'Search by breed', with: "dog"
    click_on("Search")

    expect(page).to_not have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
  end
  it 'list matches to pet age' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Elle', shelter_id: shelter.id)

    visit "/pets"
    fill_in 'Search by age', with: "3"
    click_on("Search")

    expect(page).to_not have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)

  end
  it 'can search multiple items' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Ellee', shelter_id: shelter.id)
    pet_4 = Pet.create(adoptable: true, age: 3, breed: 'cat', name: 'Elle', shelter_id: shelter.id)

    visit "/pets"
    fill_in :search_by_name, with: "Elle"
    fill_in :search_by_breed, with: "cat"
    fill_in :search_by_age, with: "3"
    click_on("Search")
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
    expect(page).to have_content(pet_4.name)

  end
  it 'can search with blank text fields correctly' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 3, breed: 'cat', name: 'Ellee', shelter_id: shelter.id)

    visit "/pets"
    fill_in :search_by_age, with: "3"
    click_on("Search")
    expect(page).to_not have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
  end
  it 'can search with blank text fields correctly additonal test' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'dog', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Ellee', shelter_id: shelter.id)
    pet_4 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Elvis', shelter_id: shelter.id)
    pet_5 = Pet.create(adoptable: true, age: 3, breed: 'cat', name: 'Elton', shelter_id: shelter.id)
    pet_6 = Pet.create(adoptable: true, age: 3, breed: 'cat', name: 'Eliott', shelter_id: shelter.id)

    visit "/pets"
    fill_in :search_by_breed, with: "dog"
    click_on("Search")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_4.name)
    expect(page).to_not have_content(pet_5.name)
    expect(page).to_not have_content(pet_6.name)
  end
  it 'will return nothing if no pet matches the criteria' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 3, breed: 'cat', name: 'Ellee', shelter_id: shelter.id)

    visit "/pets"
    fill_in :search_by_name, with: "Elle"
    fill_in :search_by_breed, with: "dog"
    fill_in :search_by_age, with: "3"
    click_on("Search")
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end
  it 'will return nothing if no pet matches the criteria additonal' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dog', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 3, breed: 'cat', name: 'Ellee', shelter_id: shelter.id)

    visit "/pets"
    fill_in :search_by_name, with: "Elle"
    fill_in :search_by_breed, with: "sphynx"
    fill_in :search_by_age, with: "3"
    click_on("Search")
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end
end
