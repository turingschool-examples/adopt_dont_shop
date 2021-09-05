require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_numericality_of(:zip) }
  end

  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @app_1 = Application.create!(name: "Cindy Lou Who", address: "123 Some Street", city: "Chicago", state: "IL", zip: "12345", description: "I'm a who for crying out loud.")
    @app_pet_1 = ApplicationPet.create!(pet: @pet_1, application: @app_1)
  end

  describe 'instance methods' do
    describe '#full_address' do
      it 'combines different parts to make a full address' do
        expect(@app_1.full_address).to eq("123 Some Street, Chicago, IL 12345")
      end
    end

    describe '#pending' do
      it 'updates status to pending' do
        expect(@app_1.status).to eq("In Progress")
        @app_1.status_pending
        expect(@app_1.status).to eq("Pending")
      end
    end
  end
end
