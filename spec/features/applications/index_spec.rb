require 'rails_helper'

RSpec.describe 'the applications index page' do
  before :each do
    @app_1 = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "I'm ready to love again" )
    @app_2 = Application.create!(name: "Benjamin Blue", street_address: "545 Boston Street", city: "Houston", state: "New York", zip_code: 02115, description: "I'm also ready")
  end

  it "shows all applications and all their attributes" do
    visit "/applications"

    expect(page).to have_content(@app_1.id)
    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_1.created_at)
  end

  it "links to show page" do
    visit "/applications"
    save_and_open_page
  
    within first(".row") do
      click_on("#{@app_1.name}")
    end

    expect(current_path).to eq("/applications/#{@app_1.id}")
  end

  it "links to edit page" do
    visit "/applications"

    within first(".row") do
      click_on("Edit #{@app_1.name}")
    end

    expect(current_path).to eq("/applications/edit")
  end

  it "links to delete page" do
    visit "/applications"

    within first(".row") do
      click_on("Delete #{@app_1.name}")
    end

    expect(current_path).to eq("/applications")
  end

  xit "allows the user to delete a pet" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    click_on("Delete #{pet.name}")

    expect(page).to have_current_path('/pets')
    expect(page).to_not have_content(pet.name)
  end
end