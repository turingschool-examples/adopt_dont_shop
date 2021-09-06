require "rails_helper"

RSpec.describe "application show page" do
  before :each do
    @application = Application.create!(name: "Andrew Massey", street: "560 Wakefield Dr", city: "Charlotte", state: "NC", zip: 28056, message: "Please choose me!", status:"In Progress")
    @shelter = Shelter.create!(name: "Charlotte Humane Society", city: 'Charlotte, NC', foster_program: true, rank: 1)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    ApplicationPet.create!(application: @application, pet:  @pet_1)
  end

  it "shows all application info" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip)
    expect(page).to have_content(@application.message)
    expect(page).to have_content(@application.status)
  end

  it "has a search field to add pets" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Add a Pet to this Application")
    fill_in "Search for Pet by Name", with: "Lobster"
    click_button "Search"
    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content("Lobster")
  end

  it "adds pets to the application when the button is clicked" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Add a Pet to this Application")
    fill_in "Search for Pet by Name", with: "Lobster"
    click_button "Search"
    expect(page).to have_content("Lobster")
    click_button "Adopt this Pet"
    expect(current_path).to eq("/applications/#{@application.id}")
    save_and_open_page
    expect(page).to have_content("Lobster")
  end
end
