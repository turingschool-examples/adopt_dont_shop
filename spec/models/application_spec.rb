require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:application_pets)}
    it { should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }

  end

  describe 'instance methods' do
    before :each do
   		@application = Application.create!(name: "Tyler R", street_address:"1000 Something Blvd",
  										  city: "Denver", state: "CO", zipcode: 80123)
  		@shelter = Shelter.create!(name: "Max Fund", city: "Denver", rank: 100, foster_program:true)
  		@pet_1 = @shelter.pets.create!(name: "Dianne", age: 3, breed: "cat?", adoptable: true)
  	end
    describe '#pets_added' do
      it 'lists all pets associated with application' do
        application_pet= ApplicationPet.create!(pet: @pet_1, application: @application)

        expect(@application.pets_added).to eq([@pet_1])
      end

    end
  end

end
