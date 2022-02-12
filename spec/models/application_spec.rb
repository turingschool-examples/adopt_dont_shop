require 'rails_helper'

RSpec.describe Application, type: :model do 

    before :each do 
        @application = Application.create!(name: "Aedan", street_address: "3425 Mansfield", city: "Denver", state: "CO", zipcode: "80236")
    end
    describe 'validations' do
        it {should validate_presence_of :name}
        it {should validate_presence_of :street_address}
        it {should validate_presence_of :city}
        it {should validate_presence_of :state}
        it {should validate_presence_of :zipcode}
        # it {should validate_presence_of :description}
    end 

    describe 'relationship' do 
        it {should have_many :pet_applications}
        it {should have_many(:pets).through(:pet_applications)}
    end
 
    it 'enum' do 
        application = Application.create!(name: "Aedan", street_address: "3425 Mansfield", city: "Denver", state: "CO", zipcode: "80236", description: "I love dogs")
        expect(Application.statuses).to eq({"In Progress"=>0, "Pending"=>1, "Accepted"=>2, "Rejected"=>3})
        expect(application.status).to eq("In Progress")
    end 

    describe 'Instance methods' do 
        it  'can add a pet to the application' do 
            application_1 = Application.create!(name: "Sedan", street_address: "3425 Fansfield", city: "Denver", state: "CO", zipcode: "80219", description: "I love dogs")
            application_2 = Application.create!(name: "Roman", street_address: "2354 Narwal", city: "Littleton", state: "CO", zipcode: "80219", description: "I'm lonely")
            dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
            # mushu = @application_1.pets.create!(adoptable: true, age: "5", breed: "Dog", name:"Mushu", shelter: dumb_friends_league )
            # mantis = @application_1.pets.create!(adoptable: true, age: "2", breed: "cat", name:"Mantis", shelter: dumb_friends_league )
            # bo = @application_2.pets.create!(adoptable: false, age: "5", breed: "Dog", name:"Bo", shelter: dumb_friends_league )
            moe = Pet.create!(adoptable: true, age: "6", breed: "Dog", name:"Moe", shelter: dumb_friends_league)
            expect(application_1.pets).to eq([])
            application_1.adopt(moe)
            expect(application_1.pets).to eq([moe])
        end 
    end     
end 