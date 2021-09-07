require 'rails_helper'

RSpec.describe 'Admin application show page' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Atlanta shelter', city: 'Atlanta, GA', foster_program: true, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Charlotte shelter', city: 'Charlotte, NC', foster_program: true, rank: 2)
    @shelter_4 = Shelter.create!(name: 'Seattle shelter', city: 'Seattle, WA', foster_program: true, rank: 8)

    @application = Application.create!(name: "Andrew Massey", street: "560 Wakefield Dr", city: "Charlotte", state: "NC", zip: 28056, message: "Please choose me!", status:"Pending")
    @lucille = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @buddy = @shelter_2.pets.create!(adoptable:true, age:5, breed: "lab", name:"Buddy", shelter_id: @shelter_1.id)
    @application_pet = ApplicationPet.create!(application: @application, pet: @lucille, status: nil)
    @application_pet_2 = ApplicationPet.create!(application: @application, pet: @buddy, status: nil )
  end

  it 'has a button beside every pet to approve the application for that specific pet' do
    visit "/admin/applications/#{@application.id}"

    expect(page).to have_button("Approve Adoption for #{@buddy.name}")
    expect(page).to have_button("Approve Adoption for #{@lucille.name}")
  end

  it 'has approves the application when the button is clicked' do
    visit "/admin/applications/#{@application.id}"

    expect(@application_pet.status).to eq(nil)

    click_button("Approve Adoption for #{@lucille.name}")

    @application_pet.reload
    
    expect(@application_pet.status).to eq("Approved")
  end
end
