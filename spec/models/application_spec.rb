require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:application_pets)}
    it {should have_many(:pets).through(:application_pets)}
  end

  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Atlanta shelter', city: 'Atlanta, GA', foster_program: true, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Charlotte shelter', city: 'Charlotte, NC', foster_program: true, rank: 2)
    @shelter_4 = Shelter.create!(name: 'Seattle shelter', city: 'Seattle, WA', foster_program: true, rank: 8)

    @application = Application.create!(name: "Andrew Massey", street: "560 Wakefield Dr", city: "Charlotte", state: "NC", zip: 28056, message: "Please choose me!", status:"Pending")
    @application_2 = Application.create!(name:"Natalie", street: "123 Road", city: "Charlotte", state: "NC", zip: 28056, message: "I want them", status: "Pending")
    @lucille = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @buddy = @shelter_2.pets.create!(adoptable:true, age:5, breed: "lab", name:"Buddy", shelter_id: @shelter_1.id)
    @bozo = @shelter_2.pets.create!(adoptable:true, age:5, breed: "lab", name:"Bozo", shelter_id: @shelter_1.id)
    @application_pet = ApplicationPet.create!(application: @application, pet: @lucille, status: "Approved")
    @application_pet_2 = ApplicationPet.create!(application: @application, pet: @buddy, status: "Approved")
    @application_pet_3 = ApplicationPet.create!(application: @application_2, pet: @bozo, status: "Rejected")

  end

  it "update_status!" do
    @application.update_status!
    expect(@application.status).to eq("Approved")
  end

  it "all_approved?" do
    expect(@application.all_approved?).to eq(true)
    expect(@application_2.all_approved?).to eq(false)
  end
end
