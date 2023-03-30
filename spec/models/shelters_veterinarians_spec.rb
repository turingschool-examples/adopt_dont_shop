require 'rails_helper'

RSpec.describe ShelterVeterinarian, type: :model do
  describe 'relationships' do
    it {should belong_to :veterinarian}
    it {should belong_to :shelter}
  end
end