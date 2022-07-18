require 'rails_helper'

RSpec.describe Application do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications)}
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
  end
  describe 'instance methods' do
    describe 'status method' do
      it 'returns In progress if no pets are added to applications' do
        app = Application.create!(name: 'Mo', street_address: '123', city: 'PDX', state: 'OR', zipcode: 97266)
        
        expect(app.status).to eq('In Progress')
      end
      it 'returns In progress if pets are added, but we havent submitted the application' do
        shelter = Shelter.create!(name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
        app = Application.create!(name: 'Mo', street_address: '123', city: 'PDX', state: 'OR', zipcode: 97266)
        pet = Pet.create!(name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: shelter.id)
        pet_application = PetApplication.create!(application_id: app.id, pet_id: pet.id)

        expect(app.description).to eq(nil)
        expect(app.status).to eq('In Progress')
      end
      it 'returns Pending after we submit the application(description is not nil)' do
        shelter = Shelter.create!(name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
        app = Application.create!(name: 'Mo', street_address: '123', city: 'PDX', state: 'OR', zipcode: 97266)
        pet = Pet.create!(name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: shelter.id)
        pet_application = PetApplication.create!(application_id: app.id, pet_id: pet.id)
        app.update_attributes(description: 'I love dogs')
        expect(app.description).to eq('I love dogs')
        expect(app.status).to eq('Pending')
      end
    end
  end
end