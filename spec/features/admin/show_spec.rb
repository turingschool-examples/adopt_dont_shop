require 'rails_helper'

RSpec.describe "Admin applications Show" do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

    @application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham", state: "AL", zip_code: "54738", description: 'empty')

    @pet_1.applications << @application_1
    @pet_2.applications << @application_1
  end

  it "shows an admin application" do

    p admin_applications_path(@application_1.id)
    visit admin_applications_path(@application_1.id)
#    expect(current_path).to eq("application_path(#{@application_1.id})"
#     save_and_open_page
#    click_link("Mr. Pirate")
    # save_and_open_page
#    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end
end
