require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe 'relationships' do
    it {belong_to :application}
    it {belong_to :pet}
  end
end
