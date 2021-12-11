require 'rails_helper'
RSpec.describe AppPet do 
  describe 'relationships' do 
    it { should belong_to(:app)}
    it { should belong_to(:pet)}
  end 
end 