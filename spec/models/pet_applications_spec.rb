require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe 'validations' do 
    it { should validate_presence_of(:application_id) }
    it { should validate_presence_of(:pet_id) }
  end

  describe '#instance methods' do
    describe '#status' do
      it 'returns current status of pet application' do
        @application = Application.create!(name: "Brian", street_address: "853 West Linden st", city: "Louisville", state: "colorado", zip_code: "80027", description: "I like animals")
        @shelter = Shelter.create!(foster_program: true, name: "Boulder Humane Society", city: "Boulder", rank: 1)
        @jax = @application.pets.create!(adoptable: false, age: 4, breed: "ACD", name: "Jax", shelter: @shelter)
        @rylo = @application.pets.create!(adoptable: false, age: 1, breed: "Lab", name: "Rylo", shelter: @shelter)

        expect(@jax.pet_applications.status(@application.id)).to eq("In Progress")
      end
    end
  end
end