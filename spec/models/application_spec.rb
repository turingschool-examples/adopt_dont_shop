require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relatioinships' do
    it { should have_many(:application_pets) }
  end
end
