require 'rails_helper'

RSpec.describe Petition do
  describe 'relationships' do
    it {should have_many(:pets) }

  end
end