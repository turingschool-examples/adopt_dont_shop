require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should have_many(:pets).through(:pet_application_pets) }
  end

  describe 'status' do
    let(:status) { ['In Progress', 'Pending', 'Accepted', 'Rejected'] }
      it 'sets correct status' do
      status.each_with_index do |stat, index|
        expect(PetApplication.statuses[stat]).to eq(index)
      end
    end
  end
end
