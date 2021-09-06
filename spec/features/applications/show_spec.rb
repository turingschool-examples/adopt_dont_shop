require "rails_helper"

RSpec.describe "application show page" do
  before :each do
    @application = Application.create!(name: "Andrew Massey", street: "560 Wakefield Dr", city: "Charlotte", state: "NC", zip: 28056, message: "Please choose me!")
    @shelter = Shelter.create!(name: "Charlotte Humane Society", city: 'Charlotte, NC', foster_program: true, rank: 1)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    ApplicationPet.create!(application: @application, pet:  @pet_1)
    ApplicationPet.create!(application: @application, pet:  @pet_2)
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
end
