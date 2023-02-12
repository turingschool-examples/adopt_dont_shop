require 'rails_helper'

RSpec.describe Petition, type: :model do
  describe 'relationships' do
    it { should have_many(:petition_pets) }
    it { should have_many(:pets).through(:petition_pets) }
  end

  describe "#class methods" do
    describe "#can_add_pet?" do
      it "can return the petitions application status as 'In Progress'" do
        petition = Petition.create!(name: 'John', street_address: '1 Sesame St', city: 'Denver',
        state: 'CO', zip_code: 12345, description: 'I like dogs', status: 'Pending')
    
        petition.can_add_pet?

        expect(petition.status).to eq('In Progress')
      end
    end
  end
end