require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe 'relationships' do
    it { should belong_to(:pets) }
    it { should belong_to(:applications) }
  end
end
