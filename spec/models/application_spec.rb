require 'rails_helper'

RSpec.describe Application, type: :model do 
    describe "relationships" do 
        it {should have_many :application_pets}
        it {should have_many(:pets).through(:application_pets)}
    end 

    describe 'instance methods' do 
        before(:each) do 
            @shelter1 = Shelter.create!(foster_program: true,
                                    name: 'Rocky Mountain Dog Shelter',
                                    city: 'Denver',
                                    rank: 1)
            @pet1 = @shelter1.pets.create!(adoptable: true,
                                        age: 3,
                                        breed: "Labrador Retriever",
                                        name: 'Bailey')
            @pet2 = @shelter1.pets.create!(adoptable: true,
                                        age: 1,
                                        breed: "French Bulldog",
                                        name: 'Bella')
            @pet3 = @shelter1.pets.create!(adoptable: false,
                                        age: 4,
                                        breed: "German Shepard",
                                        name: 'Max')
            @application1 = Application.create!(applicant_name: 'Jacob Yarborough', 
                                            street_address: '123 Main Street', 
                                            city: 'Denver', 
                                            state: 'CO',
                                            zipcode: '80223',
                                            application_status: 'Pending',
                                            why: 'I love dogs')
            @application1.pets << @pet1
            @application1.pets << @pet2
        end 

        describe '#get_pets' do 
            it 'returns the pets associated with an application ID' do 
                expect(@application1.get_pets(@application1.id)).to include(@pet1)
                expect(@application1.get_pets(@application1.id)).to include(@pet2)
            end 
        end 

        describe '#application_info' do 
            it 'returns an application instance in the form of a hash' do 
                expected = {app: @application1}

                expect(@application1.application_info(@application1.id)).to eq(expected)
            end 
        end 

        describe '#show_pets' do 
            it 'returns all pets that have a partial match with the search term' do
                expected = {app: @application1,
                pets: Pet.where("lower(pets.name) like ?", "%b%")}
                expect(@application1.show_pets(@application1.id, "b")).to eq(expected)
            end 
        end 
    end 
end 