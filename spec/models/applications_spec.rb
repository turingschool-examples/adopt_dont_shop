require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end

  before(:each) do
    @application_1 = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave', city: 'Parker', state: 'CO', zip: '80134', description: "I'd love a new pet!", status: "Pending" )
    @application_2 = Application.create!(name: 'Kimberly Triscuit', address: '123 West 23rd Ave', city: 'Parker', state: 'CO', zip: '80134', description: "I'd love a new pet!", status: "Pending" )
    @application_3 = Application.create!(name: 'Adam Johnson', address: '123 West 23rd Ave', city: 'Parker', state: 'CO', zip: '80134', description: nil, status: "In Progress" )
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: 'Jack', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter.id)
    @pet_3 = Pet.create!(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false, shelter_id: @shelter.id)
    PetApplication.create!(pet: @pet_1, application: @application_1)
    PetApplication.create!(pet: @pet_2, application: @application_2)
  end

  it 'can find pending applications' do
    expect(Application.pending).to eq([@application_1, @application_2])
  end

  it 'can count pending applications' do
    expect(@application_1.pet_count).to eq(1)
  end
end
