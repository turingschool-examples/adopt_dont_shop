require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end

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
