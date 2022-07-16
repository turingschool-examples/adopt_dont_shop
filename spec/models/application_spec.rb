require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'application requirements' do
    @application_1 = Application.create!(name: 'John', address: '123 Main Street', city: 'Nashville', state: 'TN', zip: 37067, description: "I want a nice dog.", status: "In Progress")
    
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_presence_of(:address)}
    it { is_expected.to validate_presence_of(:state)}
    it { is_expected.to validate_presence_of(:city)}
    it { is_expected.to validate_presence_of(:zip)}
  end
end
