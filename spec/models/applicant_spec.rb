require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'relationships' do
    it { should have_many(:applicant_pets) }
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }  
  end

  describe 'class methods' do
    it 'has defaults for specific fields' do
      applicant = Applicant.create!(name: 'Gwendolyn Marina', street_address: '1234 Random Place', city: 'Tucson', state: 'Arizona', zip_code: '12345')

      expect(applicant.description).to eq('N/A')
      expect(applicant.application_status).to eq('In Progress')
    end
  end
end