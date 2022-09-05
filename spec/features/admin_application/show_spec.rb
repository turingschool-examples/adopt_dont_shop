require 'rails_helper'

RSpec.describe 'Admin application show page' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Humane Society', city: 'Englewood', foster_program: false, rank: 8)
    @shelter_2 = Shelter.create(name: 'Family Tree House', city: 'Englewood', foster_program: false, rank: 4)
    @shelter_3 = Shelter.create(name: 'Life is Better Rescue', city: 'Lakewood', foster_program: true, rank: 1)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
    @application = Application.create!(name: 'John Stamos', street_address: '63254 Random', city: "MadeUp", state: 'CA', zip_code: 65432, description: 'because Im famous', status: "Pending" )
    @application_2 = Application.create!(name: 'Jack Stamos', street_address: '4 Random', city: "MadeUp", state: 'CA', zip_code: 65432, description: 'because Im not famous', status: "Pending" )
    PetApplication.create!(application: @application, pet: @pet_1)
    PetApplication.create!(application: @application_2, pet: @pet_3)
    PetApplication.create!(application: @application, pet: @pet_3)
    PetApplication.create!(application: @application_2, pet: @pet_2)
  end

  it 'can approve a pet for adoption' do
    visit "/admin/applications/#{@application.id}"

    expect(page).to have_button("Approve application")

    within "#pets-#{@pet_1.id}" do
      click_button('Approve application')
    end
    within "#pets-#{@pet_2.id}" do
      click_button('Approve application')
    end

    expect(current_path).to eq("admin/applications/#{@application.id}")
    expect(page).to have_content('Approved')
  end
end