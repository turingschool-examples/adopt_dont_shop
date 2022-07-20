require 'rails_helper'

RSpec.describe 'the shelter show' do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.rank)
    expect(page).to have_content(shelter.city)
  end

  it "shows the number of pets associated with the shelter" do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    shelter.pets.create(name: 'garfield', breed: 'shorthair', adoptable: true, age: 1)

    visit "/shelters/#{shelter.id}"

    within ".pet-count" do
      expect(page).to have_content(shelter.pets.count)
    end
  end

  it "allows the user to delete a shelter" do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)

    visit "/shelters/#{shelter.id}"

    click_on("Delete #{shelter.name}")

    expect(page).to have_current_path('/shelters')
    expect(page).to_not have_content(shelter.name)
  end

  it 'displays a link to the shelters pets index' do
    shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_link("All pets at #{shelter.name}")
    click_link("All pets at #{shelter.name}")

    expect(page).to have_current_path("/shelters/#{shelter.id}/pets")
  end
end
