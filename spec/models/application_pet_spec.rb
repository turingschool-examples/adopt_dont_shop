require 'rails_helper'
require 'test_helper'

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe "application_pet status" do
    it 'can show a default adoption status' do
      seed_shelters
      seed_applications
      seed_pets
      seed_application_pets

      expect(@application_pet_1.status).to eq("Pending")
    end
  end
end