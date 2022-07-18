require 'rails_helper'

RSpec.describe Applicant, type: :model do

  describe 'relationships' do
   it { should have_many(:pet_applications)}
   it { should have_many(:pet_applications)}
   it { should have_many(:pets).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:street_address)}
    it { should validate_presence_of(:city)}
    it { should validate_presence_of(:state)}
    it { should validate_presence_of(:zip_code)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:application_status)}
  end

  describe 'instance#methods' do
    it 'can determine if all the fields are complete' do  
      applicant_1 = Applicant.create!(name: 'Mary Smith', street_address: '123 W Lost Ln', city: 'Denver', state: 'CO', zip_code: '80239', description: 'Words that describe')
      expect(applicant_1.has_required_fields?).to eq(true) 

      applicant_2 = Applicant.create(name: 'Mary Smith', street_address: '123 W Lost Ln', city: 'Denver', state: 'CO', zip_code: '80239', description: nil)
      expect(applicant_2.valid?).to eq(false)
    end
  end
end
