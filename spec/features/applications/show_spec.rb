require 'rails_helper'

RSpec.describe 'the application show' do
  before :each do 
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
    @app_1 = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "I'm ready to love again" )
  end
  it "shows the application and all its attributes" do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_1.street_address)
    expect(page).to have_content(@app_1.city)
    expect(page).to have_content(@app_1.state)
    expect(page).to have_content(@app_1.zip_code)
    expect(page).to have_content(@app_1.status)
  end

  it 'has text box to search for pet by name' do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content("Search for Adoptable Pets")
    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    visit "/applications/#{@app_1.id}"

    fill_in 'Search', with: "Ba"
    click_on("Search")

    expect(page).to have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_3.name)
  end

  it 'adds pet to application' do
    visit "/applications/#{@app_1.id}"

    within(".apply_to_pet") do 
      expect(page).to_not have_content("#{@pet_1.name}")
    end

    click_on("Adopt #{@pet_1.name}")

    within(".apply_to_pet") do 
      expect(page).to have_content("#{@pet_1.name}")
    end
  end
end

