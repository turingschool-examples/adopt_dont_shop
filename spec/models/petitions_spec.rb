require 'rails_helper'

RSpec.describe Petition, type: :model do
  describe 'relationships' do
    it { should have_many(:petition_pets) }
    it { should have_many(:pets).through(:petition_pets) }
  end

  describe 'set status to pending' do
    it 'can switch the status' do
      @petition = Petition.create!(name: 'John', street_address: '1 Sesame St', city: 'Denver',
                    state: 'CO', zip_code: 12345, description: 'I like dogs', status: 'In Progress')
      expect(@petition.status).to eq('In Progress')
      @petition.status_pending
      expect(@petition.status).to eq('Pending')
    end
  end
end