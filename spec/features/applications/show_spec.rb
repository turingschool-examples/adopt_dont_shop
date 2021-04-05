require 'rails_helper'

RSpec.describe "the Application show page" do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @application = Application.create!(name: "Bob Baker", address: "345 2nd St Denver, CO 80206", description: "am lonely, need pets", status: "In progress")
    PetApplication.create!(application: @application, pet: @pet_1)
    PetApplication.create!(application: @application, pet: @pet_2)
  end

  it "should show application attribtes" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end
end
