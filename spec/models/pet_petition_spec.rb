require 'rails_helper'

RSpec.describe PetPetition do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:petition) }
  end
end
