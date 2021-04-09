require "rails_helper"

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:description).allow_nil }
  end

  describe "relationships" do
    it { should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end

  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @application = Application.create!(name: "Bob Baker", address: "345 2nd St Denver, CO 80206", description: "am lonely, need pets", status: "In progress")
    PetApplication.create!(application: @application, pet: @pet_1)
  end


  describe "instance methods" do
    describe ".has_pets?" do
      it "can see if it has any pets" do
        expect(@application.has_pets?).to eq(true)
      end
    end
  end
end
