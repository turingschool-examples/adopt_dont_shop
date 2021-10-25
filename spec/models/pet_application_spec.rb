require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should have_many(:pets).through(:pet_application_pets) }
  end
end
