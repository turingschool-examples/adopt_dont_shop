require 'rails_helper'

RSpec.describe Application, type: :model do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @application = Application.create!(name: 'David',street: '1023 Makeup',city: 'Chicago', state: 'IL', zip: '60657')
    @application_2 = Application.create!(name: 'Jim', street: '123 Hello Street', city: "Denver", state: 'CO', zip: '80211')
    @pet_application = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
  end

  describe 'relationships' do
    it { should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:street)}
    it { should validate_presence_of(:city)}
    it { should validate_presence_of(:state)}
    it { should validate_presence_of(:zip)}
  end

  it 'checks to see if an application has pets' do

    expect(@application.has_pets?).to eq(true)
    expect(@application_2.has_pets?).to eq(false)
  end

  it 'checks to see the status of an application' do
    expect(@application.in_progress?).to eq(true)

  end
end
