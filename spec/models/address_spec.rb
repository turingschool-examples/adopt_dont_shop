require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'relationships' do
    it { should belong_to :application}
  end
end 
