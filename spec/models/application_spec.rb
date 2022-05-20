require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :address }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'retrieving pets' do
    it 'returns pets associated with application' do
      shelter = Shelter.create!(foster_program: true, name: 'Happy Dog', city: 'Denver', rank: 3)
      max = shelter.pets.create!(adoptable: true, age: 4, breed: 'Labrador', name: 'Max')
      sasha = shelter.pets.create!(adoptable: false, age: 2, breed: 'pitsky', name: 'sasha')
      application = Application.create!(name: 'Thomas', address: '12 Water Street, Denver, CO, 80111',
                                        description: 'Happy Home', status: 'In Progress')
      application2 = Application.create!(name: 'Sage', address: '42 Wind Avenue, Denver, CO, 80111',
                                         description: 'Happy home', status: 'In Progress')
      ApplicationPet.create!(pet: max, application: application)
      ApplicationPet.create!(pet: sasha, application: application)
      ApplicationPet.create!(pet: sasha, application: application2)
      expect(application.pets).to eq([max, sasha])
      expect(application2.pets).to eq([sasha])
    end
  end
end
