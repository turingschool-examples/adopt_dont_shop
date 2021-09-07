require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
   describe "relationships" do
     it {should belong_to :application}
    it {should belong_to :pet}
   end

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

   it "#self.find_application_pet" do
     expect(ApplicationPet.find_application_pet(@application.id, @lucille.id)).to eq(@application_pet)
   end


end
