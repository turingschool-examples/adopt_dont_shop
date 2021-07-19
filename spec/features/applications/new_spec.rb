require 'rails_helper'
RSpec.describe '' do
  before :each do
    Shelter.destroy_all
    Pet.destroy_all
    Application.destroy_all
    PetApplication.destroy_all

    @shelter1 = Shelter.create!(name: "Tre's Shelter", city: "Lakewood", rank: 1, foster_program: true)
    @shelter2 = Shelter.create!(name: "Boone's Shelter", city: "Lakewood", rank: 2, foster_program: false)

    @pet1 = Pet.create!(name: "Frank West", breed: "German Shepard", age: 2, adoptable: true, shelter_id: @shelter1.id)
    @pet2 = Pet.create!(name: "Paws", breed: "Yellow lab", age: 5, adoptable: false, shelter_id: @shelter2.id)
    @pet3 = Pet.create!(name: "Wishbone", breed: "Jack Russel", age: 3, adoptable: true, shelter_id: @shelter1.id)
    @pet4 = Pet.create!(name: "CoCo", breed: "Black lab", age: 6, adoptable: false, shelter_id: @shelter2.id)

    @application1 = Application.create!(name: "Greg", street_address: "1234 Love Dr", city: "Lakewood", state: "Co", zip_code: "80227", description: "I am a loving owner <3.", status: 0)
    @application2 = Application.create!(name: "Jojo", street_address: "5678", city: "Lakewood", state: "Co", zip_code: "80227", description: "I demand a dog now.", status: 0)
    @application3 = Application.create!(name: "Chase", street_address: "9101", city: "Lakewood", state: "Co", zip_code: "80227", description: "I have a house a job and can supply ", status: 0)
    @application4 = Application.create!(name: "Charlie", street_address: "1213", city: "Lakewood", state: "Co", zip_code: "80227", description: "I have a lovely home with a big backyard and am looking for someone to have fun with", status: 0)

    @pet_application1 = PetApplication.create!(application_id: @application1.id, pet_id: @pet1.id)
    @pet_application2 = PetApplication.create!(application_id: @application1.id, pet_id: @pet3.id)
    @pet_application3 = PetApplication.create!(application_id: @application2.id, pet_id: @pet1.id)
    @pet_application4 = PetApplication.create!(application_id: @application4.id, pet_id: @pet4.id)
    
    visit "/applications/new"
  end

  it 'can fill out a form to make a new application and redirect to the show page' do

    fill_in("Name", with: "Sami")
    fill_in("Street address", with: "6358 Brooks Dr.")
    fill_in("City", with: "Arvada")
    fill_in("State", with: "Co")
    fill_in("Zip code", with: "80006")
    fill_in("Description", with: "I Love animals and make enough money to support them and care for them in any way needed!")

    click_button('Submit Application')

    application = Application.last
    
    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Sami")
  end

  it 'can fill out half a application form and returns an error message that tells what fields that must be filled out' do

    fill_in("Name", with: "Kim")
    fill_in("Street address", with: "")
    fill_in("City", with: "Arvada")
    fill_in("State", with: "Co")
    fill_in("Zip code", with: "80006")
    fill_in("Description", with: "")

    click_button('Submit Application')
    
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Error: Street address can't be blank, Description can't be blank")
  end
end