require 'rails_helper'

RSpec.describe PetApplication, type: :model do
    describe 'relationships' do 
        it {should belong_to :pet}
        it {should belong_to :application}
    end 

    before :each do 
        PetApplication.destroy_all
        Application.destroy_all
        @application_1 = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", description: "I love me some animals.", status: "Accepted")
        @dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
        @mushu = @application_1.pets.create!(adoptable: true, age: "5", breed: "dog", name:"Mushu", shelter: @dumb_friends_league)
    end 

    describe 'enum' do 
        it 'can update an applications status for one pet' do 
        application = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", description: "I love me some animals.", status: "Accepted")
        mantis = application.pets.create!(adoptable: true, age: "5", breed: "cat", name:"Mantis", shelter: @dumb_friends_league)
        joins_row = PetApplication.create!(id: 1, pet_id: mantis.id, application_id: application.id)
        expect(joins_row.status).to eq(nil)
        joins_row.Accepted!
        expect(joins_row.status).to eq("Accepted")
        end
    end 

    describe 'class methods' do 
        it '#find_joins_row' do 
            joins_row = PetApplication.find_joins_row(@application_1, @mushu)
            expect(joins_row.first.pet_id).to eq(@mushu.id)
            expect(joins_row.last.pet_id).to eq(@mushu.id)
            expect(joins_row.first.application_id).to eq(@application_1.id)
            expect(joins_row.last.application_id).to eq(@application_1.id)
        end

        describe '#find_approved_pet_ids' do 
        it 'finds all pet ids that have been accepted for a particular application' do 
            PetApplication.destroy_all
            Application.destroy_all
            application = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", description: "I love me some animals.", status: "Accepted")
            mantis = application.pets.create!(adoptable: true, age: "5", breed: "cat", name:"Mantis", shelter: @dumb_friends_league)
            oddish = application.pets.create!(adoptable: true, age: "9", breed: "mouse", name:"Oddish", shelter: @dumb_friends_league)
            expect(application.pet_applications.first.id).to eq(mantis.pet_applications.first.id)
            expect(application.pet_applications.last.id).to eq(oddish.pet_applications.first.id)
            application.pet_applications.first.Accepted!
            expect(application.pet_applications.first.status).to eq("Accepted")
            expect(PetApplication.find_approved_pet_ids(application)).to eq([mantis.id])
        end 
      end 

      describe '#find_nil_pets' do 
      it 'finds all pet ids that have are have been neither accepted nor rejected for a particular application' do 
          PetApplication.destroy_all
          Application.destroy_all
          application = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", description: "I love me some animals.", status: "Accepted")
          mantis = application.pets.create!(adoptable: true, age: "5", breed: "cat", name:"Mantis", shelter: @dumb_friends_league)
          oddish = application.pets.create!(adoptable: true, age: "9", breed: "mouse", name:"Oddish", shelter: @dumb_friends_league)
          expect(application.pet_applications.first.id).to eq(mantis.pet_applications.first.id)
          expect(application.pet_applications.last.id).to eq(oddish.pet_applications.first.id)
          expect(application.pet_applications.first.status).to eq(nil)
          expect(application.pet_applications.last.status).to eq(nil)
          expect(PetApplication.find_nil_pets(application)).to eq([mantis, oddish])
      end 
    end 

    end
end