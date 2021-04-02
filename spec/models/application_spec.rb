require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationship' do
    it {should have_many :application_pets}
  end
end
