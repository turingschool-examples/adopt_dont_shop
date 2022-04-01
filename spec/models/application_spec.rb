require 'rails_helper'

RSpec.describe Application do
  describe 'relationships' do
    it { should have_many(:pets).through(:application_pets) }
  end
end
