require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :adoptable_pets}
    it { should have_many(:pets).through(:adoptable_pets)}

  end
end
