require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pets_applications)}
    it { should have_many(:pets).through(:pets_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of(:applicant_name)}
    it { should validate_presence_of(:address)}
    it { should validate_presence_of(:city)}
    it { should validate_presence_of(:state)}
    it { should validate_presence_of(:zip_code)}
  end
end
