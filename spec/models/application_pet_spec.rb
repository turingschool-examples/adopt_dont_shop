require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet)}
    it { should belong_to(:application)}
  end


  describe 'instance methods' do

    describe 'updated?'
      it 'shows whether an application_pet is updated' do 
     		@application_1 = Application.create!(name: "Tyler R", street_address:"1000 Something Blvd",
    										  city: "Denver", state: "CO", zipcode: 80123)
    		@shelter = Shelter.create!(name: "Max Fund", city: "Denver", rank: 100, foster_program:true)
    		@pet_1 = @shelter.pets.create!(name: "Dianne", age: 3, breed: "cat?", adoptable: true)
    	  @application_pet1 = ApplicationPet.create!(application: @application_1, pet: @pet_1)
        @application_pet1.status = 'approved'

        expect(@application_pet1.updated?).to be true


      end 
    end

  end