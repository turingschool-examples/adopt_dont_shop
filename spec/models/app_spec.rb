require 'rails_helper'

RSpec.describe App, type: :model do
  describe 'relationships' do
    it { should have_many :app_pets }
    it { should have_many(:pets).through(:app_pets) }
  end
end
