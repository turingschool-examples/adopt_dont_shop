require 'rails_helper'
 
RSpec.describe PetApplication, type: :model do
  describe "relationships" do 
    it {should belong_to :application}
    it {should belong_to :pet}
  end

  describe "queries" do
    before :each do 
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  
      @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @lucille = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
      @meowth = @shelter_3.pets.create(name: 'Meowth', breed: 'persian', age: 8, adoptable: true)
  
      @jeff = @pirate.applications.create!(applicant: "Jeff", reason: "Lonely", status: "In Progress", street: "5155 Heritage Lane", city: "Alexandria", state: "VA", zipcode: "22314")

      @hamada = @lucille.applications.create!(applicant: "Hamada", reason: "Lonely", status: "In Progress", street: "5155 Heritage Lane", city: "Alexandria", state: "VA", zipcode: "22314")

      @jeff.pets << @clawdia
      @test_application = PetApplication.create!(pet_id: @meowth.id, application_id: @jeff.id, rejected: true)
    end

    it "finds all applications based on supplied rejected and approved states, as well as application id" do
      expect(PetApplication.based_on_conditions(false, false, @jeff.id)).to eq([@pirate.pet_applications[0], @clawdia.pet_applications[0]])
      expect(PetApplication.based_on_conditions(false, false, @jeff.id)).to_not include(@lucille.applications[0])
      expect(PetApplication.based_on_conditions(true, false, @jeff.id)).to eq([@meowth.pet_applications[0]])
    end

    it "finds all applications based on supplied pet and application ids" do
      expect(PetApplication.based_on_ids(@meowth.id, @jeff.id)).to eq([@meowth.pet_applications[0]])
      expect(PetApplication.based_on_ids(@clawdia.id, @jeff.id)).to eq([@clawdia.pet_applications[0]])
      expect(PetApplication.based_on_ids(@lucille.id, @hamada.id)).to eq([@lucille.pet_applications[0]])
    end
  end
end