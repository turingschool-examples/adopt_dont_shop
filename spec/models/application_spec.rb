require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end
  describe '#full_address' do
    it 'concatenates the address colums into a single string' do
      application = Application.create!(name: 'Chris P. Bacon', street_address: '123 Main Street', city: 'Anytown', state: 'CO', zip_code: 12345, description: 'I like pets', status: 'Pending')

      expected = "123 Main Street, Anytown, CO 12345"
      expect(application.full_address).to eq(expected)
    end
  end
end