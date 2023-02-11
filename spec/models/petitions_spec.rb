require 'rails_helper'

RSpec.describe Petition, type: :model do
  describe 'relationships' do
    it { should have_many(:petition_pets) }
    it { should have_many(:pets).through(:petition_pets) }
  end
end