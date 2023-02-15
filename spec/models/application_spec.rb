require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'associations' do
    it { should have_many(:pets) }
    it { should have_many(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_presence_of(:reason_for_adoption) }
  end

  describe 'Class Methods' do
    describe '::app_pet_by_pet' do
      it 'returns the application pet object for its matching pet' do
        shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
        applicant = Application.create!(name: 'Dawson', 
        street_address: '1234 example ave.', 
        city: 'Denver', 
        state: 'CO',
        zip_code: 12345, 
        reason_for_adoption: "I love dogs",
        status: "In Progress"
        )
        applicant_2 = Application.create!(name: 'Pawson', 
        street_address: '1234 example ave.', 
        city: 'Denver', 
        state: 'CO',
        zip_code: 12345, 
        reason_for_adoption: "I love dogs",
        status: "In Progress"
        )

        application = ApplicationPet.create!(application: applicant, pet: pet_3)
        application2 = ApplicationPet.create!(application: applicant_2, pet: pet_3)


        expect(applicant.app_pet_by_pet(pet_3)).to eq(application)
      end
    end
  end
end