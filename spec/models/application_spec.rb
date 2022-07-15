require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address_street) }
    it { should validate_presence_of(:address_city) }
    it { should validate_presence_of(:address_state) }
    it { should validate_presence_of(:address_zip_code) }
    it { should validate_numericality_of(:address_zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

end
