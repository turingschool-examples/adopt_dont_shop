require 'rails_helper'

RSpec.describe App, type: :model do
  describe 'relationships' do
    it { should have_many(:pets).through(:app_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:zip_code) }
  end

  before :each do
    @craigs = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha, NE", foster_program: 'false')
      @trash = @craigs.pets.create!(adoptable: true, name: "King Trash Mouth", age: 14, breed: "Torch Key")
      @princess = @craigs.pets.create!(adoptable: true, name: "Princess Dumptruck", age: 18, breed: "Cozumel")
      @beldof = @craigs.apps.create!(
        name: "Gob Beldof", 
        address: "152 Animal Ave.", 
        city: "Omaha, NE", 
        zip_code: "19593",
        description: "We love raccoons and would like more please. They will live a good life and will not have to eat carrots. Ever.",
        status: "Pending"
      )
  end

  describe 'adopt' do
    it 'adds a pet to self.pets' do
      @beldof.adopt(@trash)
      @beldof.adopt(@princess)
      expect(@beldof.pets).to include(@trash, @princess)
    end
  end

  describe 'pet_status' do
    it 'returns a hash of key pet and value adoption approval or rejection' do
      @beldof.adopt(@trash)
      @beldof.adopt(@princess)

      AppPet.where(app_id: @beldof.id, pet_id: @trash.id).update(status: "approved")
      AppPet.where(app_id: @beldof.id, pet_id: @princess.id).update(status: "rejected")
      
      expect(@beldof.pet_status).to eq({@trash => "approved", @princess => "rejected"})
    end
  end

  describe 'update_status' do
    it 'updates the status of an app to approved if all app pets are approved' do
      @beldof.adopt(@trash)
      @beldof.adopt(@princess)
      
      AppPet.where(app_id: @beldof.id, pet_id: @trash.id).update(status: "approved")
      AppPet.where(app_id: @beldof.id, pet_id: @princess.id).update(status: "approved")

      @beldof.update_status(@beldof.pet_status.values)
      expect(@beldof.status).to eq("Approved")
    end

    it 'updates app status to rejected if any app pet is rejected' do
      @beldof.adopt(@trash)
      @beldof.adopt(@princess)
      
      AppPet.where(app_id: @beldof.id, pet_id: @trash.id).update(status: "rejected")
      AppPet.where(app_id: @beldof.id, pet_id: @princess.id).update(status: "approved")

      @beldof.update_status(@beldof.pet_status.values)
      
      expect(@beldof.status).to eq("Rejected")
    end

    it 'approval makes any pet approved for adoption unavailable' do
      @beldof.adopt(@trash)
      @beldof.adopt(@princess)
      
      AppPet.where(app_id: @beldof.id, pet_id: @trash.id).update(status: "approved")
      AppPet.where(app_id: @beldof.id, pet_id: @princess.id).update(status: "approved")

      @beldof.update_status(@beldof.pet_status.values)

      expect(@trash.adoptable).to be(false)
      expect(@princess.adoptable).to be(false)
    end
  end
end