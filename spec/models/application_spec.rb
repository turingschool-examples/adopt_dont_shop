require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  before :each do
    @shelter = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
    @pet1 = @shelter.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
    @pet2 = @shelter.pets.create!(name: "Floofy", adoptable: true, age: 7, breed: "mixed breed")
    @pet3 = @shelter.pets.create!(name: "Butters", adoptable: true, age: 6, breed: "lab")
    @pet4 = @shelter.pets.create!(name: "Fluffer", adoptable: true, age: 2, breed: "shiba inu")
    @pet5 = @shelter.pets.create!(name: "Mr. FLUFF", adoptable: true, age: 4, breed: "cockerspaniel")
    @application1 = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "In Progress")
    @application2 = Application.create!(first_name: "Peter", last_name: "Pinckens", street_address: "123 Pineapple Street", city: "Denver", state: "CO", zip_code: 72641, description: "I would really like an animal to keep me company", status: "In Progress")
    @pet_application1 = PetApplication.create!(pet: @pet1, application: @application1)
    @pet_application2 = PetApplication.create!(pet: @pet2, application: @application1)
    @pet_application3 = PetApplication.create!(pet: @pet3, application: @application2)
  end

  describe '#instance methods' do


  end

  describe '#class methods' do
    xit 'should find all associated pets with an application' do
      expect(Application.find_associated_pets).to eq([@pet1, @pet2])
    end

    describe '#find_desired_pets' do
      it 'can return pets that match the inputted pet name' do
        expect(Application.find_desired_pets("Fluffy")).to eq([@pet1])
      end
      it 'can return pets that partially match the inputted pet name' do
        expect(Application.find_desired_pets("Fluff")).to eq([@pet1, @pet4])
      end
      it 'can return pets that partially match the inputted pet name, ignoring case' do
        expect(Application.find_desired_pets("Fluff")).to eq([@pet1, @pet4])
      end
    end
  end
end
