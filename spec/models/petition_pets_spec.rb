require 'rails_helper'

RSpec.describe PetitionPet, type: :model do
  describe 'relationships' do
    it { should belong_to :petition }
    it { should belong_to :pet }
  end
end