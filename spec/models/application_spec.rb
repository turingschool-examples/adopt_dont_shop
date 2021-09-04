require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many(:application_pets)}
    it {should have_many(:pets).through(:application_pets)}
  end
end
