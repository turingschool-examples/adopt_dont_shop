require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zipcode)}
    it {should validate_presence_of(:description)}
  end

  describe "Instance methods" do
    describe '#has_pets_added?' do
      it "returns true if the application has added pets" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")
        shelter = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        becky = shelter.pets.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky")

        ApplicationPet.create!(pet: becky, application: application)

        expect(application.has_pets_added?).to eq(true)
      end
    end

    describe "application_approved?" do
      it "checks if number of approved pets equals number of pets on application" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "Pending")
        shelter_1 = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

        becky = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky", shelter: shelter_1)
        bean = Pet.create!(adoptable: true, age: 3, breed: "Bulldog", name: "Bean", shelter: shelter_3)

        ApplicationPet.create!(pet: becky, application: application, status: "Approved")
        ApplicationPet.create!(pet: bean, application: application, status: "Approved")

        expect(application.application_approved?).to be true
      end
    end
  end
end
