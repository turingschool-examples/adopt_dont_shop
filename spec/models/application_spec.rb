require 'rails_helper'
require 'test_helper'

RSpec.describe Application, type: :model do
  before :each do
    @shelter_1 = Shelter.create!(
      foster_program: true,
      name: "Healthy Paws",
      city: "Denver",
      rank: 3
    )

    @application_1 = Application.create!(
      name: "Bob",
      street_address: "123 Leaf Street",
      city: "Denver",
      state: "CO",
      zip_code: 80020
    )

    @application_2 = Application.create!(
      name: "Tom",
      street_address: "508 Maple Street",
      city: "Denver",
      state: "CO",
      zip_code: 80020,
      description: "Love animals",
      status: "Pending"
    )
  
    @application_3 = Application.create!(
      name: "Sam",
      street_address: "8591 Pine Street",
      city: "Denver",
      state: "CO",
      zip_code: 80021,
      description: "Have a large yard for a furbaby",
      status: "Pending"
    )
  
    @application_4 = Application.create!(
      name: "Susan",
      street_address: "2210 Palm Street",
      city: "Denver",
      state: "CO",
      zip_code: 80240,
      description: "Looking for a running  buddy",
      status: "In Progress"
    )
  end

  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
  end

  describe "#full_address" do
    it 'can create a full address' do
      expect(@application_1.full_address).to eq("123 Leaf Street, Denver, CO 80020")
    end
  end
  
  describe "attribute status" do
    it 'can show a default status' do
      expect(@application_1.status).to eq('In Progress')
    end
  end

  describe "#has_pets?" do
    it 'tells if an application has pets' do
      expect(@application_1.has_pets?).to be false

      @application_1.pets.create!(
        name: "Pepper",
        adoptable: true,
        age: 4,
        breed: "Pitbull",
        shelter_id: @shelter_1.id
      )
      
      expect(@application_1.has_pets?).to be true
    end
  end
end 