require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first) }
    it { should validate_presence_of(:last) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  describe 'class methods' do
    before(:each) do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
      @app_1 = Application.create!(first: "Joe", last: "Hill", street: "Street", city: "Any Town", state: "AnyState", zip: "12345", description: "So cute!", status: "Pending")
      ApplicationPet.create!(pet: @pet_1, application: @app_1)
    end
    describe '#applications_by_shelter' do
      it 'returns an array of shelter objects who have pets with "Pending" applications' do
        expect(Application.applications_by_shelter).to eq([@shelter_1])
      end
    end

    describe '#pets_in_applications_by_shelter' do
      it 'returns a hash with all the pets in that application and their accept/reject status' do
        expect(@app_1.pets_in_application_to_approve).to eq({@pet_1 => nil})
      end
    end
  end
end
