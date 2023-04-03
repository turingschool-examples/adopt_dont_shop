require 'rails_helper'

RSpec.describe Application, type: :model do
  
  describe "relationships" do
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end
  
  describe "validations" do
    it {should validate_presence_of(:applicant_name)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip_code)}
    it {should validate_presence_of(:status)}
  end
  
  
  describe "class methods" do
    
  end
  
  describe "instance methods" do
    describe "update_status" do
      before(:each) do
        @shelter_1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
        @pet_1 = @shelter_1.pets.create!(name: "Foster", age: 1000, breed: "dog")
        @pet_2 = @shelter_1.pets.create!(name: "Bento", age: 23, breed: "dog")
        @pet_3 = @shelter_1.pets.create!(name: "Quiggle", age: 555,)
        @pet_4 = @shelter_1.pets.create!(name: "Simpleton", age: 80,)
        @pet_5 = @shelter_1.pets.create!(name: "Dragon", age: 400,)
        @application_1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals", status: "Pending")
        @application_2 = Application.create!(applicant_name: "Nebula", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods", status: "Pending")
        @application_3 = Application.create!(applicant_name: "Angry Tim", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Approved")
        PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id, condition: "Approved")
        PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id, condition: "Approved")
        PetApplication.create!(pet_id: @pet_5.id, application_id: @application_1.id, condition: "Approved")
        PetApplication.create!(pet_id: @pet_2.id, application_id: @application_2.id, condition: "Rejected")
        PetApplication.create!(pet_id: @pet_4.id, application_id: @application_2.id, condition: "Pending")
        PetApplication.create!(pet_id: @pet_4.id, application_id: @application_3.id, condition: "Rejected")
        PetApplication.create!(pet_id: @pet_5.id, application_id: @application_3.id, condition: "Rejected")
      end
      it 'changes application status to "Approve" if its pet applications have condition as Approved' do
        expect(@application_1.status).to eq("Pending")
        @application_1.update_status
        expect(@application_1.status).to eq("Approved")
      end

      it 'status stays as "Pending if not pet_applications conditions are approved or rejected' do
        expect(@application_2.status).to eq("Pending")
        @application_2.update_status
        expect(@application_2.status).to eq("Pending")
      end

      it 'status changes to rejected if any pet_application conditions are rejected and no more are pending' do
        expect(@application_3.status).to eq("Pending")
        @application_3.update_status
        expect(@application_3.status).to eq("Rejected")
      end
    end
  end
end

