require 'rails_helper'

RSpec.describe PetsPetApp do
  describe 'relationships' do
    it {should belong_to :pet}
    it {should belong_to :pet_application}
  end
end
