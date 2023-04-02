require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe "instance methods" do
    before do
      @shelter_1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
      @pet_1 = @shelter_1.pets.create!(name: "Foster", age: 1000, breed: "dog")
      @pet_2 = @shelter_1.pets.create!(name: "Bento", age: 23, breed: "dog")
      @pet_3 = @shelter_1.pets.create!(name: "Quiggle", age: 555,)
      @pet_4 = @shelter_1.pets.create!(name: "Simpleton", age: 80,)
      @pet_5 = @shelter_1.pets.create!(name: "Snapchat", age: 799,)
      @application_1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals")
      @application_2 = Application.create!(applicant_name: "Nebula", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods", status: "Pending")
      @application_3 = Application.create!(applicant_name: "Angry Tim", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Approved")
      @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
      @pet_application_2 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
      @pet_application_3 = PetApplication.create!(pet_id: @pet_5.id, application_id: @application_1.id)
      @pet_application_4 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_2.id)
      @pet_application_5 = PetApplication.create!(pet_id: @pet_4.id, application_id: @application_2.id)
      @pet_application_6 = PetApplication.create!(pet_id: @pet_4.id, application_id: @application_3.id)
      @pet_application_7 = PetApplication.create!(pet_id: @pet_5.id, application_id: @application_3.id)
    end

    it "Can update its condition" do
      expect(@pet_application_1.condition).to eq("Pending")
      expect(@pet_application_6.condition).to eq("Pending")

      @pet_application_1.change_condition("Approved")
      @pet_application_6.change_condition("Denied")

      expect(@pet_application_1.condition).to eq("Approved")
      expect(@pet_application_6.condition).to eq("Denied")
    end
  end
end