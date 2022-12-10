require 'rails_helper'

RSpec.describe Application do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_numericality_of(:zipcode) }
    # it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  describe 'associations' do
    it {should have_many(:pet_applications)}
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe '#get_pets' do
    it 'retrieves all pets associated with the application' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "In Progress")
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      PetApplication.create!(pet: pet_1, application: application)
      PetApplication.create!(pet: pet_2, application: application)

      expect(application.get_pets).to eq([pet_1, pet_2])
    end
  end
end