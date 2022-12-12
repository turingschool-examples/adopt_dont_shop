require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets)}
  end

  before(:each) do
    @app1 = Application.create!(name: "Max", 
                                street_address: "Made up St", city: "Denver", 
                                state: "CO", 
                                zip_code: "80000", 
                                description: "Love mix breeds. Lots of energy to play with a dog", 
                                status: "In Progress")
    @app2 = Application.create!(name: "Alastair", 
                                street_address: "Fictional St", 
                                city: "Golden", 
                                state: "CO", 
                                zip_code: "80001", 
                                description: "Love big dogs. Great mountain walks on doorstep", 
                                status: "Accepted")
    @shelter = Shelter.create!(name: 'Aurora shelter', 
                                city: 'Aurora, CO', 
                                foster_program: false, 
                                rank: 9)
    @pet1 = @app1.pets.create!(name: 'Noodle', 
                                age: 2, 
                                breed: 'Border Collie', 
                                adoptable: true, 
                                shelter_id: @shelter.id)
    @pet2 = @app1.pets.create!(name: 'Hercules', 
                                age: 2, 
                                breed: 'American Akita', 
                                adoptable: true, 
                                shelter_id: @shelter.id)
    @pet3 = @app1.pets.create!(name: 'Bumblebee', 
                                age: 1, 
                                breed: 'Welsh Corgi', 
                                adoptable: true,
                                shelter_id: @shelter.id)
  end

  describe 'class methods' do
    describe '#pet_search' do
      it 'returns partial matches & case insensitive' do

        expect(@app1.pet_search("her")).to eq([@pet2])
        expect(@app1.pet_search("Noo")).to eq([@pet1])
      end
    end

    describe '#has_pets?' do
      it 'returns true is the application has more than 0 pets' do

        expect(@app1.has_pets?).to eq true
        expect(@app2.has_pets?).to eq false
      end
    end
  end
end