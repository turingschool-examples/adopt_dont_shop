require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end
    describe 'validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:address) }
      it { should validate_presence_of(:rationale) }
      it { should validate_presence_of(:status) }
      it { should validate_presence_of(:city) }
      it { should validate_presence_of(:state) }
      it { should validate_presence_of(:zipcode) }
  end

  it "returns true if it has pets" do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    scooby = shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    piglet = shelter.pets.create!(name: 'Piglet',  age: 1, breed: 'Micro Pig', adoptable: true, shelter_id: shelter.id)

    application_1 = Application.create!(name: 'Shaggy', address: '2541 Spooky Lane', city: 'Coolsville', state: 'Ohio', zipcode: '12345', rationale: 'I want a best friend to eat Scooby snacks with', status: 'In-progress')

    application_pet1 = ApplicationPet.create!(pet_id: scooby.id, application_id: application_1.id)
    application_pet2 = ApplicationPet.create!(pet_id: piglet.id, application_id: application_1.id)

    
    expect(application_1.has_pets?).to eq(true)
  end

end
