require 'rails_helper'

RSpec.describe Application, type: :model do
  let!(:application_1) { Application.create!(name: "John Doe", 
                                           street_address: "123 Main St", 
                                           city: "Denver", 
                                           state: "CO", 
                                           zip_code: "80202", 
                                           description: "I love dogs", 
                                           status: "In Progress") }
  let!(:application_2) { Application.create!(name: "Bob Smith", 
                                          street_address: "123 South Ln", 
                                          city: "Milwaukee", 
                                          state: "WI", 
                                          zip_code: "12345", 
                                          description: "Dogs are great", 
                                          status: "Rejected") }
  let!(:shelter) { Shelter.create!(name: "Best Friends Animal Society", city: "Los Angeles", foster_program: true, rank: 1) }                                         

  describe 'relationships' do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
  end

  describe 'attributes' do
    it 'has attributes' do
      expect(application_1).to be_a(Application)
      expect(application_1.name).to eq("John Doe")
      expect(application_1.street_address).to eq("123 Main St")
      expect(application_1.status).to eq("In Progress")
    end
  end

  describe 'class methods' do
    it ".eligible?" do
      expect(application_1.eligible?).to eq(false)
      expect(application_2.eligible?).to eq(false)

      application_1.pets << shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
      expect(application_1.eligible?).to eq(true)
    end
  end
end