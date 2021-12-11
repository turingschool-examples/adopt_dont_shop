require 'rails_helper' 
RSpec.describe App do 
  describe 'relationships' do 
    it { should have_many(:pets)}
    it { should have_many(:pets).through(:app_pets)}
  end 
end 