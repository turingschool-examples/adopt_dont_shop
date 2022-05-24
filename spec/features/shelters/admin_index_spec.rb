RSpec.describe 'the shelters admin index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application1 = Application.create!(name: 'Andrew', street: "123 Street", city: "Kenosha",
    state: "WI", zip: 53144, description: "This is a description of why I'm a good fit.",
    application_status: "In Progress")
    @application2 = Application.create!(name: 'Eric', street: "345 Street", city: "Denver",
    state: "CO", zip: 22387, description: "This is a better description of why I'm a good fit.",
    application_status: "In Progress")

  end

  it 'lists all the shelter in reverse alphabetical order by name' do
    visit "/admin/shelters"

    within "#shelter-0" do
      expect(page).to have_content(@shelter_2.name)
    end

    within "#shelter-1" do
      expect(page).to have_content(@shelter_3.name)
    end

    within "#shelter-2" do
      expect(page).to have_content(@shelter_1.name)
    end
  end

  it 'lists all shelter names with pending applications' do
    visit "/admin/shelters"

    expect(page).to have_content("Shelter's with Pending Applications")

    within "#shelter-pending" do
      expect(page).to_not have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_3.name)
    end

    visit "/applications/#{@application1.id}"

    fill_in "Search", with: "Clawdia"
    click_button "Search"
    click_button "Adopt Clawdia"
    fill_in "description", with: "This is a description."
    click_button "Submit"

    visit "/admin/shelters"

    within "#shelter-pending" do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_3.name)
    end
  end
end
