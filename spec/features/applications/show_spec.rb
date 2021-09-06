require 'rails_helper'

RSpec.describe 'application show page' do
  before(:each) do
    @app_1 = Application.create!(
      name: "Sarah Carter",
      address: "1108 Ichabod St",
      city: "North Pole",
      state: "Alaska",
      zip: "99705",
      description: "I will name him George, and I will hug him, and pet him, and squeeze him")
    @shelter = Shelter.create!(name: 'Cheyenne Animal Shelter', city: 'Cheyenne', foster_program: false, rank: 2)
    @pet_1 = @shelter.pets.create!(name: 'Cassio', age: 2, breed: 'Akbash', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(name: 'Bianca', age: 1, breed: 'Great Pyrenees',  adoptable: true, shelter_id: @shelter.id)
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2
  end

  it "displays all the applicant params and the app status" do
    visit "/applications/#{@app_1.id}"
    save_and_open_page
    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_1.address)
    expect(page).to have_content(@app_1.city)
    expect(page).to have_content(@app_1.state)
    expect(page).to have_content(@app_1.zip)
    expect(page).to have_content(@app_1.status)
    expect(page).to have_content(@app_1.description)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)

    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@pet_2.name}")

    click_link("#{@pet_1.name}")
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end
end
