require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
    @shelter2 = Shelter.create(name: 'Coon City', street_address: '201 W Colfax Ave', city: 'Denver', state: 'CO', zip_code: 80202, foster_program: false, rank: 5)
    @shelter3 = Shelter.create(name: 'Cat Savers', street_address: '1455 High St', city: 'Denver', state: 'CO', zip_code: 80218, foster_program: true, rank: 10)
    @shelter1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'lists all the shelter names' do
    visit "/shelters"

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter2.name)
    expect(page).to have_content(@shelter3.name)
  end

  it 'lists the shelters by most recently created first' do
    visit "/shelters"

    expect(@shelter3.name).to appear_before(@shelter2.name)
    expect(@shelter2.name).to appear_before(@shelter1.name)

    within "#shelters > tr:nth-child(4)" do
      expect(page).to have_content(@shelter1.created_at)
    end

    within "#shelters > tr:nth-child(3)" do
      expect(page).to have_content(@shelter2.created_at)
    end

    within "#shelters > tr:nth-child(2)" do
      expect(page).to have_content(@shelter3.created_at)
    end
  end

  it 'has a link to sort shelters by the number of pets they have' do
    visit '/shelters'

    expect(page).to have_link("Sort by number of pets")
    click_link("Sort by number of pets")

    expect(page).to have_current_path('/shelters?sort=pet_count')
    expect(@shelter1.name).to appear_before(@shelter3.name)
    expect(@shelter3.name).to appear_before(@shelter2.name)
  end

  it 'has a link to update each shelter' do
    visit "/shelters"

    within "#shelters > tr:nth-child(4)" do
      expect(page).to have_link("Update #{@shelter1.name}")
    end

    within "#shelters > tr:nth-child(3)" do
      expect(page).to have_link("Update #{@shelter2.name}")
    end

    within "#shelters > tr:nth-child(2)" do
      expect(page).to have_link("Update #{@shelter3.name}")
    end

    click_on("Update #{@shelter1.name}")
    expect(page).to have_current_path("/shelters/#{@shelter1.id}/edit")
  end

  it 'has a link to delete each shelter' do
    visit "/shelters"

    within "#shelters > tr:nth-child(2)"  do
      expect(page).to have_link("Delete #{@shelter3.name}")
    end

    within "#shelters > tr:nth-child(3)" do
      expect(page).to have_link("Delete #{@shelter2.name}")
    end

    within "#shelters > tr:nth-child(4)"  do
      expect(page).to have_link("Delete #{@shelter1.name}")
    end

    click_link("Delete #{@shelter1.name}")

    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(@shelter1.name)
  end

  it 'has a text box to filter results by keyword' do
    visit "/shelters"
    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    visit "/shelters"

    fill_in 'Search', with: "Coon"
    click_on("Search")

    expect(page).to have_content(@shelter2.name)
    expect(page).to_not have_content(@shelter1.name)
  end
end
