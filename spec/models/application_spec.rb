require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pets).through(:application_pets)}
  end

  describe 'instance method' do
    describe '#add_pet' do
      it 'adds an instance of pet to application.pets' do
        app = Application.create!(name: "Miley Cyrus", street_address: "123 Hollywood Blvd", city: "Los Angeles", state: "California", zipcode: 12345, description: "I am rich and hot", status: "In Progress")
        shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        scooby = shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
        sm_scooby = shelter.pets.create!(name: 'Scooby', age: 6, breed: 'Chihuahua', adoptable: true)
        other_scooby = shelter.pets.create!(name: 'mr. scooby', age: 1, breed: 'Dalmation', adoptable: true)
        scrappy = shelter.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true)

        app.add_pet(scooby.id)

        expect(app.pets).to eq([scooby])
      end
    end

    describe '#to_pending' do
      it 'changes the status to pending' do
        app = Application.create!(name: "Miley Cyrus", street_address: "123 Hollywood Blvd", city: "Los Angeles", state: "California", zipcode: 12345, description: "I am rich and hot", status: "In Progress")
        expect(app.status).to eq("In Progress")

        app.to_pending

        expect(app.status).to eq("Pending")
      end
    end
  end

  
end