require 'rails_helper'
RSpec.describe 'it can go to the show page of the application table and show its attributes' do
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
    
    visit "/applications/#{@application1.id}"
  end

  it 'can visit the show page' do
    
    expect(current_path).to eq("/applications/#{@application1.id}")
  end

  it 'it can show all the attributes on the show page' do
    
    expect(page).to have_content("#{@application1.name}")
    expect(page).to have_content("#{@application1.street_address}")
    expect(page).to have_content("#{@application1.city}")
    expect(page).to have_content("#{@application1.state}")
    expect(page).to have_content("#{@application1.zip_code}")
    expect(page).to have_content("#{@application1.description}")
    expect(page).to have_content("#{@application1.status}")
    expect(page).to_not have_content("#{@application2.name}")
  end

  it 'shows all the pets associated with this application' do
    
    expect(page).to have_content("#{@pet1.name}")
    expect(page).to have_content("#{@pet3.name}")
  end

  it 'has links to the pets show pages that are associated with this application' do
    expect(page).to have_link("#{@pet1.name}")
    
    click_link("#{@pet1.name}")

    expect(current_path).to eq("/pets/#{@pet1.id}")
  end

  it 'can fill out the search bar and pets names show up underneath it' do

    fill_in('Pet Finder', with: 'Paw')
    
    click_button("Find that Pet!")

    expect(page).to have_content("#{@pet2.name}")
    expect(page).to have_content("#{@pet2.breed}")
    expect(page).to have_content("#{@pet2.age}")

    expect(page).to_not have_content("#{@pet4.name}")
  end

  it 'can fill out the pet finder and click the adopt button to associate the application and that pet' do
    fill_in('Pet Finder', with: 'Paw')
    
    click_button("Find that Pet!")

    click_button("Adopt #{@pet2.name}")

    expect(page).to_not have_content("#{@pet4.breed}")
    expect(page).to_not have_content("#{@pet4.age}")

  end
end