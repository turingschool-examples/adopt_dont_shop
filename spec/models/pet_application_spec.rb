require 'rails_helper'

RSpec.describe Pet Application, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should have_many(:application) }
  end
