require 'rails_helper'

RSpec.describe "the Application show page" do
  before :each do
    @shelter = Shelter.create!(name: 'Portland Animal Shelter', city: 'Portland, OR', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'russian blue', name: 'Cowboy', shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(adoptable: true, age: 3, breed: 'golden retriever', name: 'Juniper', shelter_id: @shelter.id)
    @application = Application.create!(name: "Alan Smithee", address: "742 Evergreen Terrace", city: "Springfield", state: "OR", zip_code: 97205, description: "Looking for a lockdown companion", status: "In progress")
    PetApplication.create!(application: @application, pet: @pet_1)
    PetApplication.create!(application: @application, pet: @pet_2)
  end

  it "shows application attribtes" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end
end