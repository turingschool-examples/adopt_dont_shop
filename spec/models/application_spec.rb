require 'rails_helper'

describe Application do
  describe 'relationship' do
    it { should have_many(:pets).through(:application_pets) }
  end
end