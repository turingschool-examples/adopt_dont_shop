require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end
  let(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let(:application) { Application.create!(
                                    name: "Nate Brown",
                          street_address: "2000 35th Avenue",
                                    city: "Denver",
                                   state: "CO",
                                     zip: "90210",
                             description: "I have a big backyard",
                                  status: "Pending"
                                         )}
  describe "attributes" do
    it 'has name, full address, description, and status' do
      expect(application.name).to eq("Nate Brown")
      expect(application.full_address).to eq("2000 35th Avenue, Denver, CO, 90210")
      expect(application.description).to eq("I have a big backyard")
      expect(application.status).to eq("Pending")
    end
  end

  describe "#add_pet_to_application" do
    it 'adds pet to application' do
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      application.add_pet_to_application(pet_1)

      expect(application.pets).to include(pet_1)
    end
  end

  describe "#check_status" do
    before(:each) do
      @application_1 = Application.create!(
                                        name: "Nate Brown the 3rd",
                              street_address: "2000 35th Avenue",
                                        city: "Denver",
                                       state: "CO",
                                         zip: "90210",
                                 description: "Big ass backyard",
                                      status: "Pending"
                                             )
      @pet_1 = Pet.create!(name: 'Jonathan Whiskers', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter: shelter)
      @pet_2 = Pet.create!(name: 'Jack Handy', breed: 'shorthair', age: 3, adoptable: true, shelter: shelter)

      @application_pet_1 = ApplicationPet.create!(application: @application_1, pet: @pet_1)
      @application_pet_2 = ApplicationPet.create!(application: @application_1, pet: @pet_2)
    end
    context 'when all pets on application are approved' do
      it 'changes application status to approved' do

        @application_pet_1.approve
        @application_pet_2.approve

        @application_1.check_status

        expect(@application_1.status).to eq("Approved")
      end
    end
    context 'when one pet is approved and one or more other pets are pending' do
      it 'leaves application status as Pending' do
        @application_pet_1.approve
        @application_1.check_status
        expect(@application_1.status).to eq("Pending")
      end
    end
    context 'one or more pets are rejected' do
      it 'changes application status to rejected' do
        @application_pet_1.approve
        @application_pet_2.reject

        @application_1.check_status

        expect(@application_1.status).to eq("Rejected")
      end
    end
  end
end
