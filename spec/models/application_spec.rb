require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do    
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_presence_of(:address)}
    it { is_expected.to validate_presence_of(:state)}
    it { is_expected.to validate_presence_of(:city)}
    it { is_expected.to validate_presence_of(:zip)}
    it {should allow_value("In Progress").for(:status)}
    it {should allow_value("Pending").for(:status)}
    it {should allow_value("Accepted").for(:status)}
    it {should allow_value("Rejected").for(:status)}
  end
end
