require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'lists all the shelter names' do
    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it 'lists the shelters by most recently created first' do
    visit "/shelters"

    oldest = find("#shelter-#{@shelter_1.id}")
    mid = find("#shelter-#{@shelter_2.id}")
    newest = find("#shelter-#{@shelter_3.id}")

    expect(newest).to appear_before(mid)
    expect(mid).to appear_before(oldest)

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_content("Created at: #{@shelter_1.created_at}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_content("Created at: #{@shelter_2.created_at}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_content("Created at: #{@shelter_3.created_at}")
    end
  end

  it 'has a link to sort shelters by the number of pets they have' do
    visit '/shelters'

    expect(page).to have_link("Sort by number of pets")
    click_link("Sort by number of pets")

    expect(page).to have_current_path('/shelters?sort=pet_count')
    expect(@shelter_1.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_2.name)
  end

  it 'has a link to update each shelter' do
    visit "/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Update #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Update #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Update #{@shelter_3.name}")
    end

    click_on("Update #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")
  end

  it 'has a link to delete each shelter' do
    visit "/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Delete #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Delete #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Delete #{@shelter_3.name}")
    end

    click_on("Delete #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
  end

  it 'has a text box to filter results by keyword' do
    visit "/shelters"
    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    visit "/shelters"

    fill_in 'Search', with: "RGV"
    click_on("Search")

    expect(page).to have_content(@shelter_2.name)
    expect(page).to_not have_content(@shelter_1.name)
  end

  it 'admin routes to index page with priviledge' do
    visit '/admin/shelters'

    expect(page).to have_content("All Shelters")
  end

  it 'has a section for shelters with pending applications' do
    mystery_shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: mystery_shelter.id)
    clifford = Pet.create!(name: 'Clifford', age: 1, breed: 'Red Dog', adoptable: true, shelter_id: mystery_shelter.id)
    john_application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CO', zipcode: '90210', description: 'we love pets', status: 'Pending')
    PetApplication.create!(pet: scooby, application: john_application)
    PetApplication.create!(pet: clifford, application: john_application)


    fancy_shelter = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    lucille = Pet.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: fancy_shelter.id)
    sarah_application = Application.create!(name: 'Sarah Smith', street_address: '456 banana street', city: 'Mars', state: 'AZ', zipcode: '07653', description: 'I love pets', status: 'In Progress')
    PetApplication.create!(pet: lucille, application: sarah_application)

    visit '/admin/shelters'

    within "#shelters_with_pending_apps" do 
      expect(page).to have_content("Shelters with Pending Applications")
      expect(page).to have_content("Mystery Building")
      expect(page).to_not have_content("Fancy pets of Colorado")
   end 
  end
end