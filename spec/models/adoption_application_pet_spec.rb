require 'rails_helper'

RSpec.describe AdoptionApplicationPet do
  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :adoption_application }
  end
end
