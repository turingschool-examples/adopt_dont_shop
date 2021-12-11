require 'rails_helper'

describe PetApplication do
  describe 'relationships' do
    it {should belong_to(:pet)}
    it {should belong_to(:application)}
  end
end
