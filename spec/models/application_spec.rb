require 'rails_helper'

RSpec.describe Application, type: :model do
  before :each do
    @application_1 = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals!')
    @application_2 = Application.create!(name: 'Jane Doe', address: '456 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals!', status: 1)
    @application_3 = Application.create!(name: 'John Smith', address: '789 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I eat animals!', status: 2)
    @application_4 = Application.create!(name: 'Jane Smith', address: '101 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I hate animals!', status: 3)
  end
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'enum' do
    it 'has an enum for status' do
      expect(Application.statuses).to eq({"In Progress" => 0, "Pending" => 1, "Accepted" => 2, "Rejected" => 3})
    end

    it 'enum has a default status of In Progress' do
      expect(@application_1.status).to eq('In Progress')
    end

    it 'enum has a status of Pending' do
      expect(@application_2.status).to eq('Pending')
    end

    it 'enum has a status of Accepted' do
      expect(@application_3.status).to eq('Accepted')
    end

    it 'enum has a status of Rejected' do
      expect(@application_4.status).to eq('Rejected')
    end
  end
end