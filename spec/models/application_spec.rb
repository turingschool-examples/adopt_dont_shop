require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
  end

  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'status' do
    let(:status) { ['In Progress', 'Pending', 'Accepted', 'Rejectd'] }

    it 'has the right index' do
      status.each_with_index do |item, index|
        expect(Application.statuses[item]).to eq(index)
      end
    end
  end
end
