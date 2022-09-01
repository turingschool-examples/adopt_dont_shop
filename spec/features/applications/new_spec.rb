require 'rails_helper'

RSpec.describe 'Application show page' do
  before :each do
    @shelter = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha")

    @pet_1 = @shelter.pets.create!(name: "King Trash Mouth", age: 14)
    @pet_2 = @shelter.pets.create!(name: "Princess Dumptruck", age: 18)

    @app = App.create!(
      name: "Gob Beldof", 
      address: "152 Animal Ave.", 
      city: "Omaha", 
      state: "NE", 
      zip_code: "19593",
      description: "We love raccoons and would like more please. They will live a good life and will not have to eat carrots. Ever.",
      links_to_pets: "/pets/#{@pet_1.id}, /pets/#{@pet_2.id}",
      status: "Pending"
    )

    visit "apps/#{@app.id}"
  end

  it 'displays the attributes of the selected application' do
    save_and_open_page
    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.address)
    expect(page).to have_content(@app.city)
    expect(page).to have_content(@app.state)
    expect(page).to have_content(@app.zip_code)
    expect(page).to have_content(@app.description)
    expect(page).to have_content(@app.links_to_pets)
    expect(page).to have_content(@app.status)
  end
end