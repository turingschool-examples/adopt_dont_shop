require 'rails_helper'
RSpec.describe 'it can go to the show page of the application table and show its attributes' do
  before :each do
    Pet.destroy_all
    Application.destroy_all
    PetApplication.destroy_all

    @shelter1 = Shelter.create!(name: "Tre's Shelter", city: "Lakewood", rank: 1, foster_program: true)
    @shelter2 = Shelter.create!(name: "Boone's Shelter", city: "Lakewood", rank: 2, foster_program: false)

    @pet1 = Pet.create!(name: "Frank West", breed: "German Shepard", age: 2, adoptable: true, shelter_id: @shelter1.id)
    @pet2 = Pet.create!(name: "Paws", breed: "Yellow lab", age: 5, adoptable: false, shelter_id: @shelter2.id)
    @pet3 = Pet.create!(name: "Wishbone", breed: "Jack Russel", age: 3, adoptable: true, shelter_id: @shelter1.id)
    @pet4 = Pet.create!(name: "CoCo", breed: "Black lab", age: 6, adoptable: false, shelter_id: @shelter2.id)

    @application1 = Application.create!(name: "Greg", address: "1234 Love Dr", description: "I am a loving owner <3.", status: 0)
    @application2 = Application.create!(name: "Jojo", address: "5678 ", description: "I demand a dog now.", status: 0)
    @application3 = Application.create!(name: "Chase", address: "9101", description: "I have a house a job and can supply ", status: 0)
    @application4 = Application.create!(name: "Charlie", address: "1213", description: "", status: 0)

    @pet_application1 = PetApplication.create!(application_id: @application1.id, pet_id: @pet1.id)
    @pet_application2 = PetApplication.create!(application_id: @application1.id, pet_id: @pet3.id)
    @pet_application3 = PetApplication.create!(application_id: @application2.id, pet_id: @pet1.id)
    @pet_application4 = PetApplication.create!(application_id: @application4.id, pet_id: @pet4.id)
    
    visit "/applications/#{@application1.id}"
  end

  it 'can visit the show page' do
    
    expect(current_path).to eq("/applications/#{@application1.id}")
  end

  it 'it can show all the attributes on the show page' do
    
  end
end