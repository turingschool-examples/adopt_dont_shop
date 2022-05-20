require 'rails_helper'

RSpec.describe Application, type: :model do 
    describe 'relationships' do 
        it { should have_many :pet_applications }
        it { should have_many(:pets).through(:pet_applications) }
    end

    describe 'instance methods' do 
        describe 'Application Show Page User Story' do 
            it '#pets_wanted' do 
                shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
                pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
                pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
                pet_3 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
                application1 = Application.create!(
                    name: 'Joe Exotic', 
                    street_address: '3150 Horton Rd', 
                    city: 'Fort Worth', 
                    state: 'TX', 
                    zip_code: 76119,
                    description: 'I just really love animals'
                )
                application2 = Application.create!(
                name: 'Carol Baskins', 
                street_address: '12802 Easy St', 
                city: 'Tampa', 
                state: 'FL', 
                zip_code: 33625,
                description: 'I just really love animals more than that other guy'
            )
                pet_application_1 = PetApplication.create!(pet: pet_1, application: application1)
                pet_application_2 = PetApplication.create!(pet: pet_2, application: application2)
                pet_application_3 = PetApplication.create!(pet: pet_3, application: application2)
                

                expect(application1.pets_wanted).to eq([pet_1])
                expect(application2.pets_wanted).to eq([pet_2, pet_3])
            end
        end
    end
end