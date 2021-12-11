require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'relationships' do
    it { validate_presence_of(:address) }
    it { should belong_to :application}
  end
end
