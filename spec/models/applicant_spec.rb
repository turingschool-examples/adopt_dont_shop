require 'rails_helper'

RSpec.describe Applicant, type: :model do
    before(:each) do
        @applicant1 = Applicant.create!(name: "Judge Judy", street_address: "666 Elm St", city: "New Jersey", state: "NJ", zip: "8675309", good_fit: "I am a Judgy Motha")
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet1 = @shelter_1.pets.create!(adoptable: true, age: 4, breed: "Rotweiller", name: "Raider")
    end

    describe 'relationships' do 
        it {should have_many :pet_applicants}
        it {should have_many(:pets).through(:pet_applicants)}
    end   

    describe 'instance methods' do 
        describe '#pets?' do 
            it 'returns true if application has pets' do 
                expect(@applicant1.pets?).to eq(false)
                @applicant1.pets << @pet1
                expect(@applicant1.pets?).to eq(true)
            end
        end
    end
end