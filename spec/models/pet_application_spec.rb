require 'rails_helper'

RSpec.describe PetApplication, type: :model do
    describe 'relationships' do 
        it {should belong_to :pet}
        it {should belong_to :application}
    end 

    describe 'enum' do 
        it 'can update an applications status for one pet' do 
        PetApplication.destroy_all
        # application_1 = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", description: "I really love animals.", status: "Pending")
        # dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
        # mushu = application_1.pets.create!(adoptable: true, age: "5", breed: "dog", name:"Mushu", shelter: dumb_friends_league)
        joins_row = PetApplication.create(id: 1, pet_id: 1, application_id: 2)
        expect(joins_row.status).to eq(nil)
        joins_row.Accepted!
        expect(joins_row.status).to eq("Accepted")
        end
    end 

    describe 'class methods' do 
        it '#find_joins_row' do 
            PetApplication.destroy_all
            application_1 = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", description: "I really love animals.", status: "Pending")
            dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
            mushu = application_1.pets.create!(adoptable: true, age: "5", breed: "dog", name:"Mushu", shelter: dumb_friends_league)
            joins_row = PetApplication.find_joins_row(application_1, mushu)
            expect(joins_row.first.pet_id).to eq(mushu.id)
            expect(joins_row.last.pet_id).to eq(mushu.id)
            expect(joins_row.first.application_id).to eq(application_1.id)
            expect(joins_row.last.application_id).to eq(application_1.id)
        end
    end
end