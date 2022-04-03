require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_may :petapplications }
    it { should have_may :pets, through: :petapplications }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    
  end
end 
